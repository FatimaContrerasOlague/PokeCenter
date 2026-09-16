import 'package:flutter/material.dart';
import 'package:PokeCenter/widgets/menu_button.dart';
import 'package:PokeCenter/widgets/responsive_panel.dart';

const _tradeYellow = Color(0xFFE5D36D);

class PokemonTradeScreen extends StatelessWidget {
  const PokemonTradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: const Color(0xFF130F20),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/poke_center/tradeF1.jpeg',
            key: const Key('trade-background'),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.none,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: MenuButton(onPressed: () => Navigator.maybePop(context)),
            ),
          ),
          Positioned(
            left: screenWidth * 0.03,
            top: screenHeight * 0.15,
            width: screenWidth * 0.99,
            height: screenHeight * 0.65,
            child: Image.asset(
              'assets/images/poke_center/trade.png',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: screenWidth * 0.022,
            top: screenHeight * 0.792,
            width: screenWidth * 0.96,
            height: screenHeight * 0.119,
            child: ResponsivePanel(
              height: screenHeight * 0.119,
              padding: EdgeInsets.zero,
              borderWidth: screenWidth * 0.015,
              borderRadius: BorderRadius.circular(screenWidth * 0.053),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.036),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/poke_center/characters/npc1.png',
                      width: screenWidth * 0.179,
                      height: screenHeight * 0.076,
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.none,
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '{idUsuario}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.008),
                            // Seis Poké Balls provisionales.
                            Semantics(
                              label: '6 Poké Balls usadas (provisional)',
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  6,
                                  (index) => Container(
                                    width: screenWidth * 0.085,
                                    height: screenWidth * 0.095,
                                    margin: EdgeInsets.only(
                                      right: index < 5
                                          ? screenWidth * 0.018
                                          : 0,
                                    ),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _tradeYellow,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
