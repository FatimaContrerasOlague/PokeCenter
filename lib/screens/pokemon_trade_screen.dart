import 'package:flutter/material.dart';

class PokemonTradeScreen extends StatelessWidget {
  const PokemonTradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            'assets/images/poke_center/test1.png',
            fit: BoxFit.cover,
          ),


          // Positioned(
          //   left: screenWidth * - 0.10,
          //   bottom: screenHeight * 0.418,
          //   width: screenWidth * 0.50,
          //   child: Image.asset(
          //     'assets/images/poke_center/cuadrados.png',
          //     fit: BoxFit.contain,
          //   ),
          // ),
          
          // Positioned(
          //   left: screenWidth * - 0.30,
          //   bottom: screenHeight * 0.618,
          //   width: screenWidth * 0.40,
          //   child: Image.asset(
          //     'assets/images/poke_center/flecha.png',
          //     fit: BoxFit.contain,
          //   ),
          // ),


        ],
      ),
    );
  }
}