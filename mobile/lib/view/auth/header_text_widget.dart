import 'package:flutter/material.dart';

import '../../common/utils.dart';

class HeaderTextWidget extends StatelessWidget {
  final String title;
  final String desc;
  final Widget icon;
  const HeaderTextWidget({
    super.key,
    required this.title,
    required this.desc,
    this.icon = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      color: darkBlueColor,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            icon,
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              desc,
              style: const TextStyle(color: Colors.white70),
            )
          ],
        ),
      ),
    );
  }
}
