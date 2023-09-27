import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/utils.dart';
import '../auth/auth_state_notifier.dart';

class CustomTextButton extends StatelessWidget {
  final List<dynamic> likes;
  final List<dynamic> replies;
  final VoidCallback onLikeTap;
  final VoidCallback onReplyTap;
  const CustomTextButton(
      {super.key,
      required this.likes,
      required this.replies,
      required this.onLikeTap,
      required this.onReplyTap});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final userId = ref.watch(authProvider).value;
      return Padding(
        padding: const EdgeInsets.only(left: 58),
        child: Row(
          children: [
            TextButton(
                onPressed: onLikeTap,
                child: Row(
                  children: [
                    Text(
                      'Likes',
                      style: TextStyle(
                          color: likes.contains(userId)
                              ? primaryLightColor
                              : Colors.black),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${likes.isEmpty ? '' : likes.length}',
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                )),
            const SizedBox(width: 8),
            TextButton(
                onPressed: onReplyTap,
                child: Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    const Text('Reply'),
                    const SizedBox(width: 4),
                    Text(
                      '${replies.isEmpty ? '' : replies.length}',
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    )
                  ],
                )),
          ],
        ),
      );
    });
  }
}
