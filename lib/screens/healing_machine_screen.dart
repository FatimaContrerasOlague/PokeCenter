import 'package:PokeCenter/widgets/menu_button.dart';
import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }
}

