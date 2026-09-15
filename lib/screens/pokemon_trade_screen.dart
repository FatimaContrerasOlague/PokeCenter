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
            left: screenWidth * 0.213,
            top: screenHeight * 0.052,
            width: screenWidth * 0.143,
            height: screenHeight * 0.076,
            child: ResponsivePanel(
              height: screenHeight * 0.076,
              padding: EdgeInsets.zero,
              borderWidth: screenWidth * 0.015,
              borderRadius: BorderRadius.circular(screenWidth * 0.053),
              child: const SizedBox.shrink(),
            ),
          ),
          Positioned(
            left: screenWidth * 0.396,
            top: screenHeight * 0.031,
            width: screenWidth * 0.589,
            height: screenHeight * 0.119,
            child: ResponsivePanel(
              height: screenHeight * 0.119,
              padding: EdgeInsets.zero,
              borderWidth: screenWidth * 0.015,
              borderRadius: BorderRadius.circular(screenWidth * 0.053),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.036),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/images/poke_center/characters/npc1.png',
                    width: screenWidth * 0.179,
                    height: screenHeight * 0.076,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.none,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.438,
            top: screenHeight * 0.187,
            width: screenWidth * 0.476,
            height: screenHeight * 0.236,
            child: ResponsivePanel(
              height: screenHeight * 0.236,
              padding: EdgeInsets.zero,
              borderWidth: screenWidth * 0.015,
              borderRadius: BorderRadius.circular(screenWidth * 0.053),
              child: const SizedBox.expand(key: Key('partner-slot')),
            ),
          ),
          Positioned(
            left: screenWidth * 0.147,
            top: screenHeight * 0.239,
            width: screenWidth * 0.266,
            height: screenHeight * 0.157,
            child: const _TradeArrow(),
          ),
          Positioned(
            left: screenWidth * 0.053,
            top: screenHeight * 0.487,
            width: screenWidth * 0.476,
            height: screenHeight * 0.236,
            child: ResponsivePanel(
              height: screenHeight * 0.236,
              padding: EdgeInsets.zero,
              borderWidth: screenWidth * 0.015,
              borderRadius: BorderRadius.circular(screenWidth * 0.053),
              child: const SizedBox.expand(key: Key('player-slot')),
            ),
          ),
          Positioned(
            left: screenWidth * 0.589,
            top: screenHeight * 0.501,
            width: screenWidth * 0.26,
            height: screenHeight * 0.153,
            child: const RotatedBox(quarterTurns: 2, child: _TradeArrow()),
          ),
          Positioned(
            left: screenWidth * 0.022,
            top: screenHeight * 0.792,
            width: screenWidth * 0.59,
            height: screenHeight * 0.119,
            child: ResponsivePanel(
              height: screenHeight * 0.119,
              padding: EdgeInsets.zero,
              borderWidth: screenWidth * 0.015,
              borderRadius: BorderRadius.circular(screenWidth * 0.053),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.036),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/poke_center/characters/npc1.png',
                    width: screenWidth * 0.179,
                    height: screenHeight * 0.076,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.none,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.661,
            top: screenHeight * 0.813,
            width: screenWidth * 0.143,
            height: screenHeight * 0.076,
            child: ResponsivePanel(
              height: screenHeight * 0.076,
              padding: EdgeInsets.zero,
              borderWidth: screenWidth * 0.015,
              borderRadius: BorderRadius.circular(screenWidth * 0.053),
              child: const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TradeArrow extends StatelessWidget {
  const _TradeArrow();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _TradeArrowPainter());
  }
}

class _TradeArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * .16)
      ..lineTo(size.width * .68, size.height * .16)
      ..lineTo(size.width * .68, 0)
      ..lineTo(size.width, size.height * .31)
      ..lineTo(size.width * .68, size.height * .61)
      ..lineTo(size.width * .68, size.height * .46)
      ..lineTo(size.width * .33, size.height * .46)
      ..lineTo(size.width * .33, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = _tradeYellow);
  }

  @override
  bool shouldRepaint(_TradeArrowPainter oldDelegate) => false;
}
