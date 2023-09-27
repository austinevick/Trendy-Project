import 'package:flutter/material.dart';

import 'custom_button.dart';

class SocialButton extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onPressed;
  const SocialButton({
    super.key,
    required this.image,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomButton(
        onPressed: onPressed,
        borderSide: BorderSide(color: Colors.grey.shade300),
        radius: 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/$image.png', height: 30),
            const SizedBox(width: 4),
            Text(text)
          ],
        ),
      ),
    );
  }
}
