import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const MenuButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final menuSize =
      (MediaQuery.sizeOf(context).width * 0.40).clamp(54.0, 66.0).toDouble();

    return IconButton(
      onPressed: onPressed,
      tooltip: 'Abrir menu',
      padding: EdgeInsets.zero,
      iconSize: menuSize,
      icon: SizedBox(
        width: menuSize,
        height: menuSize,
        child: Image.asset(
          'assets/images/menu.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}