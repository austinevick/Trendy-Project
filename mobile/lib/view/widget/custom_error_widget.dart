import 'package:flutter/material.dart';

import '../../common/api.dart';
import '../../common/utils.dart';
import 'custom_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomErrorWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.wifi_off, color: Colors.grey, size: 100),
        InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              retry,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
        ),
        CustomButton(
            text: 'Retry',
            textSize: 16,
            height: 40,
            textColor: primaryLightColor,
            onPressed: onPressed,
            width: 200)
      ],
    );
  }
}
