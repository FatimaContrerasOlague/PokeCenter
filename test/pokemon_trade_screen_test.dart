import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_center/screens/pokemon_center_screen.dart';
import 'package:poke_center/screens/pokemon_trade_screen.dart';

void main() {
  testWidgets('Opens trade from the center and loads its background', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: PokemonCenterScreen()));
    await tester.pump(const Duration(seconds: 2));
    await tester.tap(find.text('>>'));
    await tester.pump(const Duration(seconds: 2));
    await tester.tap(find.text('IR A LA MAQUINA DE INTERCAMBIO'));
    await tester.pumpAndSettle();

    expect(find.byType(PokemonTradeScreen), findsOneWidget);
    final background = tester.widget<Image>(
      find.byKey(const Key('trade-background')),
    );
    final asset = background.image as AssetImage;
    await tester.runAsync(() async {
      final data = await rootBundle.load(asset.assetName);
      final decoded = await decodeImageFromList(data.buffer.asUint8List());
      expect(decoded.width, greaterThan(0));
      decoded.dispose();
    });
    expect(find.byKey(const Key('partner-slot')), findsOneWidget);
    expect(find.byKey(const Key('player-slot')), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.byTooltip('Abrir menu'));
    await tester.pumpAndSettle();
    expect(find.byType(PokemonCenterScreen), findsOneWidget);
  });
}
