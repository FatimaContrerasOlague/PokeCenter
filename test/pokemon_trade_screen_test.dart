import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:PokeCenter/screens/pokemon_center_screen.dart';
import 'package:PokeCenter/screens/pokemon_trade_screen.dart';

void main() {
  testWidgets('Opens trade from the center and loads its background', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: PokemonCenterScreen()),
    );
    await tester.tap(find.text('Intercambiar Pokémon'));
    await tester.pumpAndSettle();

    expect(find.byType(PokemonTradeScreen), findsOneWidget);
    final background = tester.widget<Image>(
      find.descendant(
        of: find.byType(PokemonTradeScreen),
        matching: find.byType(Image),
      ),
    );
    final asset = background.image as AssetImage;
    await tester.runAsync(() async {
      final data = await rootBundle.load(asset.assetName);
      final decoded = await decodeImageFromList(data.buffer.asUint8List());
      expect(decoded.width, greaterThan(0));
      decoded.dispose();
    });
    expect(tester.takeException(), isNull);
  });
}
