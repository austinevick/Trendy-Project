import 'package:flutter/material.dart';

import '../../../model/blog/blog_response_data.dart';

class RepostBottomSheet extends StatelessWidget {
  const RepostBottomSheet({super.key, required this.data});

  final BlogResponseData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () {},
          leading: const Icon(Icons.edit_document, size: 30),
          title: const Text(
            'Repost with quotes',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            'Create a new post with ${data.author.firstName}\'s post attached',
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.repeat_rounded, size: 30),
          title: const Text(
            'Repost',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
              'Instantly bring ${data.author.firstName}\'s post to others\' feeds',
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey)),
        )
      ],
    );
  }
}
