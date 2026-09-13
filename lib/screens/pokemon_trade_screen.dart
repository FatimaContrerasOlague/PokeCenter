import 'package:flutter/material.dart';

class PokemonTradeScreen extends StatelessWidget {
  const PokemonTradeScreen({super.key});

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
            'assets/images/poke_center/tradeF1.jpeg',
            fit: BoxFit.cover,
          ),
          Positioned(
            left: screenWidth * - 0.10,
            bottom: screenHeight * 0.418,
            width: screenWidth * 0.50,
            child: Image.asset(
              'assets/images/poke_center/characters/chansey2.png',
              fit: BoxFit.contain,
            ),
          ),
          
        ],
      ),
    );
  }
}