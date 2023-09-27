import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String tooltip;
  final Color? color;
  final IconData icon;
  final VoidCallback onPressed;
  const CustomIconButton(
      {super.key,
      required this.tooltip,
      this.color,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 25,
          color: color,
        ),
      ),
    );
  }
}
