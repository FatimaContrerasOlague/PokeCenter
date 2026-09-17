import 'dart:async';

import 'package:flutter/material.dart';
import 'package:poke_center/screens/chansey_screen.dart';
import 'package:poke_center/screens/healing_machine_screen.dart';
import 'package:poke_center/screens/pokemon_trade_screen.dart';
import 'package:poke_center/widgets/menu_button.dart';
import 'package:poke_center/widgets/responsive_panel.dart';

const _panelColor = Color(0xFF5345AB);

class PokemonCenterScreen extends StatefulWidget {
  const PokemonCenterScreen({super.key});

  @override
  State<PokemonCenterScreen> createState() => _PokemonCenterScreenState();
}

class _PokemonCenterScreenState extends State<PokemonCenterScreen> {
  static const _welcomeMessage = 'HOLA, BIENVENIDO AL CENTRO POKEMON';
  static const _destinationMessage = 'A DONDE QUIERES IR?';

  Timer? _typingTimer;
  int _dialogueIndex = 0;
  int _visibleCharacters = 0;
  int _chanseyPresses = 0;
  bool _isChanseyPressed = false;

  String get _currentMessage =>
      _dialogueIndex == 0 ? _welcomeMessage : _destinationMessage;

  bool get _isTyping => _visibleCharacters < _currentMessage.length;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _typingTimer?.cancel();
    _typingTimer = Timer.periodic(const Duration(milliseconds: 55), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_visibleCharacters >= _currentMessage.length) {
        timer.cancel();
        return;
      }

      setState(() {
        _visibleCharacters++;
      });
    });
  }

  void _showNextDialogue() {
    if (_dialogueIndex != 0) {
      return;
    }

    setState(() {
      _dialogueIndex = 1;
      _visibleCharacters = 0;
    });
    _startTyping();
  }

  void _handleChanseyTap() {
    final opensChanseyScreen = _chanseyPresses == 7;

    setState(() {
      _chanseyPresses = opensChanseyScreen ? 0 : _chanseyPresses + 1;
    });

    if (opensChanseyScreen) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ChanseyScreen()),
      );
    }
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      // appBar: AppBar(
      // title: Center(
      //    child: const Text('Centro Pokemon'),
      //    ),
      //  ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/poke_center/centerF1.jpeg',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: const MenuButton(),
            ),
          ),
          Positioned(
            left: screenWidth * -0.10,
            bottom: screenHeight * 0.374,
            width: screenWidth * 0.50,
            height: screenHeight * 0.50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/poke_center/characters/nurse1.png',
                  fit: BoxFit.contain,
                ),
                if (_isTyping)
                  Image.asset(
                    'assets/images/poke_center/characters/nurse2.png',
                    fit: BoxFit.contain,
                  ),
              ],
            ),
          ),
          Positioned(
            left: screenWidth * 0.45,
            bottom: screenHeight * 0.302,
            width: screenWidth * 0.74,
            height: screenHeight * 0.50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/poke_center/characters/chansey.png',
                  fit: BoxFit.contain,
                ),
                if (_isChanseyPressed)
                  Image.asset(
                    'assets/images/poke_center/characters/chansey2.png',
                    fit: BoxFit.contain,
                  ),
              ],
            ),
          ),
          Positioned(
            left: screenWidth * 0.45,
            bottom: screenHeight * 0.302,
            width: screenWidth * 0.74,
            height: screenHeight * 0.50,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _handleChanseyTap,
              onTapDown: (_) => setState(() => _isChanseyPressed = true),
              onTapUp: (_) => setState(() => _isChanseyPressed = false),
              onTapCancel: () => setState(() => _isChanseyPressed = false),
              child: Opacity(
                opacity: 0,
                child: Image.asset(
                  'assets/images/poke_center/characters/chansey.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
  left: 10,
  right: 10,
  bottom: screenHeight * 0.10,
  child: ResponsivePanel(
    widthFactor: 1,
    padding: const EdgeInsets.all(10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Hola, bienvenido al Centro Pokémon',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'NESFont'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _panelColor,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HealingMachineScreen(),
              ),
            );
          },
          child: const Text('Ir a la máquina de curación'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _panelColor,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PokemonTradeScreen(),
              ),
            );
          },
          child: const Text('Ir a la máquina de intercambio'),
        ),
      ],
    ),
  ),
),
        ],
      ),
    );
  }
}
