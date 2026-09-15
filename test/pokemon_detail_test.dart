import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:PokeCenter/models/pokemon_detail_response.dart';
import 'package:PokeCenter/providers/poke_api_provider.dart';
import 'package:PokeCenter/screens/pokemon_detail_screen.dart';

final fixture = {
  'id': 25,
  'name': 'pikachu',
  'height': 4,
  'weight': 60,
  'base_experience': null,
  'sprites': {
    'front_default': null,
    'other': {
      'official-artwork': {'front_default': null},
    },
  },
  'types': [
    {
      'slot': 1,
      'type': {'name': 'electric'},
    },
  ],
  'abilities': [
    {
      'slot': 3,
      'is_hidden': true,
      'ability': {'name': 'lightning-rod'},
    },
  ],
  'stats': [
    {
      'base_stat': 35,
      'effort': 0,
      'stat': {'name': 'hp'},
    },
  ],
};

class FakePokeApi extends PokeApiProvider {
  final List<int> requestedIds = [];
  bool fail = false;
  @override
  Future<http.Response> getPokemonDetail(int id) async {
    requestedIds.add(id);
    if (fail) throw Exception('Sin conexión');
    return http.Response(jsonEncode(fixture), 200);
  }
}

void main() {
  test(
    'Parsea campos anidados, valores nulos y conserva datos al serializar',
    () {
      final pokemon = PokemonDetailResponse.fromRawJson(jsonEncode(fixture));
      expect(pokemon.id, 25);
      expect(pokemon.types.single.name, 'electric');
      expect(pokemon.abilities.single.isHidden, isTrue);
      expect(pokemon.stats.single.baseStat, 35);
      expect(pokemon.baseExperience, isNull);
      expect(pokemon.sprites.imageUrl, isNull);
      expect(
        PokemonDetailResponse.fromJson(pokemon.toJson()).toJson(),
        pokemon.toJson(),
      );
      expect(PokemonDetailResponse.fromJson({}).stats, isEmpty);
      expect(
        PokemonSprites.fromJson({'front_default': 'sprite.png'}).imageUrl,
        'sprite.png',
      );
    },
  );

  Widget app(FakePokeApi api) => ChangeNotifierProvider<PokeApiProvider>.value(
    value: api,
    child: const MaterialApp(
      home: PokemonDetailScreen(pokemonId: 25, pokemonName: 'pikachu'),
    ),
  );

  testWidgets(
    'Consulta el ID seleccionado y muestra su ficha en pantalla estrecha',
    (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final api = FakePokeApi();
      await tester.pumpWidget(app(api));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
      expect(api.requestedIds, [25]);
      expect(find.text('Eléctrico'), findsOneWidget);
      expect(find.text('0.4 m'), findsOneWidget);
      expect(find.text('6.0 kg'), findsOneWidget);
      await tester.scrollUntilVisible(find.text('Total: 35'), 200);
      expect(find.text('Oculta'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(app(api));
      expect(api.requestedIds, [25]);
    },
  );

  testWidgets('Permite recuperarse de un error con Reintentar', (tester) async {
    final api = FakePokeApi()..fail = true;
    await tester.pumpWidget(app(api));
    await tester.pumpAndSettle();
    expect(find.text('No pudimos cargar este Pokémon.'), findsOneWidget);
    api.fail = false;
    await tester.tap(find.text('Reintentar'));
    await tester.pumpAndSettle();
    expect(api.requestedIds, [25, 25]);
    expect(find.text('Eléctrico'), findsOneWidget);
  });
}
