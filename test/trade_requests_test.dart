import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_center/screens/pokemon_selection_screen.dart';
import 'package:poke_center/screens/pokemon_trade_screen.dart';
import 'package:poke_center/widgets/trade_requests_dialog.dart';

void main() {
  testWidgets(
    'Incoming request selects exactly one Pokemon and carries its context',
    (tester) async {
      tester.view.physicalSize = const Size(360, 740);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        const MaterialApp(home: PokemonSelectionScreen()),
      );
      await tester.tap(find.byKey(const Key('pokemon-1')));
      await tester.tap(find.byKey(const Key('pokemon-2')));
      await tester.tap(find.byKey(const Key('trade-requests-button')));
      await tester.pumpAndSettle();
      expect(find.text('Ofrece a Pikachu'), findsOneWidget);
      expect(find.text('Ofrece a Psyduck'), findsOneWidget);
      await tester.tap(find.byKey(const Key('trade-request-1')));
      await tester.pumpAndSettle();
      expect(find.byType(TradeRequestsDialog), findsNothing);
      expect(
        find.text('Elige un Pokémon para intercambiarlo por Pikachu'),
        findsOneWidget,
      );
      expect(find.text('Solicitud de Ash Ketchum'), findsOneWidget);
      expect(
        tester
            .widget<FilledButton>(
              find.byKey(const Key('continue-request-trade')),
            )
            .onPressed,
        isNull,
      );
      await tester.tap(find.byKey(const Key('response-pokemon-3')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('response-pokemon-4')));
      await tester.pumpAndSettle();
      expect(find.text('1 / 1 seleccionado'), findsOneWidget);
      await tester.tap(find.byKey(const Key('continue-request-trade')));
      await tester.pumpAndSettle();
      final machine = tester.widget<PokemonTradeScreen>(
        find.byType(PokemonTradeScreen),
      );
      expect(machine.selectedPokemonIds, [4]);
      expect(machine.incomingRequest?.id, 1);
      expect(find.text('Ash Ketchum ofrece a Pikachu'), findsOneWidget);
      expect(
        tester
            .widget<FilledButton>(
              find.byKey(const Key('search-trainers-button')),
            )
            .onPressed,
        isNull,
      );
      Navigator.of(tester.element(find.byType(PokemonTradeScreen))).pop();
      await tester.pumpAndSettle();
      expect(find.text('2 / 6 seleccionados'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Empty requests and cancelling a response leave normal selection intact',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PokemonSelectionScreen(incomingRequests: [])),
      );
      await tester.tap(find.byKey(const Key('trade-requests-button')));
      await tester.pumpAndSettle();
      expect(
        find.text('No tienes solicitudes de intercambio.'),
        findsOneWidget,
      );
      await tester.tap(find.byTooltip('Cerrar solicitudes'));
      await tester.pumpAndSettle();
      await tester.pumpWidget(
        const MaterialApp(home: PokemonSelectionScreen()),
      );
      await tester.tap(find.byKey(const Key('trade-requests-button')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('trade-request-2')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('response-pokemon-1')));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Cerrar solicitudes'));
      await tester.pumpAndSettle();
      expect(find.byType(PokemonTradeScreen), findsNothing);
      expect(find.text('0 / 6 seleccionados'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
