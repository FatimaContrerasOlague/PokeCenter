import 'package:PokeCenter/screens/healing_machine_screen.dart';
import 'package:PokeCenter/widgets/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:PokeCenter/widgets/responsive_panel.dart';
import 'package:PokeCenter/screens/pokemon_selection_screen.dart';

const _panelColor = Color(0xFF5345AB);

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
              child: const MenuButton(),
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
  bottom: screenHeight * 0.10,
  child: ResponsivePanel(
    widthFactor: 1,
    padding: const EdgeInsets.all(10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'HOLA, BIENVENIDO AL CENTRO POKEMON',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'NESFont',color: Colors.white),
          
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
          child: const Text('IR A LA MAQUINA DE CURACION', style: TextStyle(fontFamily: 'NESFont',color: Colors.white),),
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
                builder: (context) => const PokemonSelectionScreen(),
              ),
            );
          },
          child: const Text('IR A LA MAQUINA DE INTERCAMBIO', style: TextStyle(fontFamily: 'NESFont',color: Colors.white),),
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
