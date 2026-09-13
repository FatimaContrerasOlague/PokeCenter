import 'package:flutter/material.dart';
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
    // trade
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.swap_horiz),
        label: const Text('Intercambiar Pokémon'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PokemonTradeScreen(),
            ),
          );
        },
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/poke_center/centerF1.jpeg',
            fit: BoxFit.cover,
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
        ],
      ),
    );
  }
}