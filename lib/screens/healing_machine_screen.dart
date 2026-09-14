import 'package:PokeCenter/widgets/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:PokeCenter/widgets/responsive_panel.dart';
import 'package:PokeCenter/screens/pokemon_center_screen.dart';

class HealingMachineScreen extends StatelessWidget {
  const HealingMachineScreen({super.key});

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
            'assets/images/poke_center/centerF2.jpeg',
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
                builder: (context) => const PokemonCenterScreen(),
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

