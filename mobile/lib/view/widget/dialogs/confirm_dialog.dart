import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  const ConfirmDialog({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel')),
        TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes, I know'))
      ],
    );
  }
}
