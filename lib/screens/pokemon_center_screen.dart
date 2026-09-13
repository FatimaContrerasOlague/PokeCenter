import 'package:flutter/material.dart';

class PokemonCenterScreen extends StatelessWidget {
  const PokemonCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

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
          Positioned(
            left: 16,
            bottom: 0,
            width: screenWidth * 0.35,
            child: Image.asset(
              'assets/images/poke_center/characters/nurse2.png',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            right: 16,
            bottom: 0,
            width: screenWidth * 0.35,
            child: Image.asset(
              'assets/images/poke_center/characters/nurse1.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
