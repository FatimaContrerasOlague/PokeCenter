import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_center/screens/pokemon_trade_screen.dart';

void main() {
  testWidgets(
    'Search, select and dismiss preserve trainer and Pokemon selection',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetViewInsets);
      await tester.pumpWidget(
        const MaterialApp(
          home: PokemonTradeScreen(selectedPokemonIds: [2, 7, 12]),
        ),
      );
      await tester.tap(find.byKey(const Key('search-trainers-button')));
      await tester.pumpAndSettle();
      expect(find.text('Ash Ketchum'), findsOneWidget);
      await tester.enterText(
        find.byKey(const Key('trainer-search-field')),
        ' ANDRES ',
      );
      tester.view.viewInsets = const FakeViewPadding(bottom: 300);
      await tester.pumpAndSettle();
      expect(find.text('Andrés'), findsOneWidget);
      expect(find.text('Ash Ketchum'), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.tap(find.byKey(const Key('trainer-107')));
      tester.view.resetViewInsets();
      await tester.pumpAndSettle();
      expect(find.text('Entrenador: Andrés'), findsOneWidget);
      for (final id in [2, 7, 12]) {
        expect(find.byKey(ValueKey('trade-pokemon-$id')), findsOneWidget);
      }
      await tester.tap(find.byKey(const Key('search-trainers-button')));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('trainer-search-field')),
        'zzzz',
      );
      await tester.pumpAndSettle();
      expect(
        find.text('No se encontraron entrenadores.\nPrueba con otro nombre.'),
        findsOneWidget,
      );
      await tester.tap(find.byTooltip('Limpiar búsqueda'));
      await tester.pumpAndSettle();
      expect(find.text('Ash Ketchum'), findsOneWidget);
      await tester.tap(find.byTooltip('Cerrar buscador'));
      await tester.pumpAndSettle();
      expect(find.text('Entrenador: Andrés'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
