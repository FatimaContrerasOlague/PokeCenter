import 'package:PokeCenter/screens/healing_machine_screen.dart';
import 'package:PokeCenter/widgets/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:PokeCenter/widgets/responsive_panel.dart';
import 'package:PokeCenter/screens/pokemon_trade_screen.dart';

class PokemonCenterScreen extends StatelessWidget {
  const PokemonCenterScreen({super.key});

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
              child: MenuButton(
                onPressed: () {},
              ),
            ),
          ),
          Positioned(
            left: screenWidth * - 0.10,
            bottom: screenHeight * 0.418,
            width: screenWidth * 0.50,
            child: Image.asset(
              'assets/images/poke_center/characters/nurse2.png',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
             left: screenWidth * - 0.10,
            bottom: screenHeight * 0.418,
            width: screenWidth * 0.50,
            child: Image.asset(
              'assets/images/poke_center/characters/nurse1.png',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
             left: screenWidth * 0.45,
            bottom: screenHeight * 0.418,
            width: screenWidth * 0.74,
            child: Image.asset(
              'assets/images/poke_center/characters/chansey2.png',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: screenWidth * 0.45,
            bottom: screenHeight * 0.418,
            width: screenWidth * 0.74,
            child: Image.asset(
              'assets/images/poke_center/characters/chansey.png',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
  left: 10,
  right: 10,
  bottom: screenHeight * 0.12,
  child: ResponsivePanel(
    widthFactor: 1,
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Hola, bienvenido al Centro Pokémon',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 50),
        ElevatedButton(
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
      ],
    ),
  ),
),
        ],
      ),
    );
  }
}
