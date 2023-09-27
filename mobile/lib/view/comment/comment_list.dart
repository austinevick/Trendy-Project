import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/comment/comment_response_data.dart';
import '../widget/custom_text_button.dart';
import 'comment_card.dart';

class CommentList extends StatelessWidget {
  final CommentResponseData comment;
  final VoidCallback onReplyTap;
  const CommentList(
      {super.key, required this.comment, required this.onReplyTap});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CommentCard(comment: comment),
        CustomTextButton(
            likes: comment.likes,
            replies: comment.replies,
            onLikeTap: () {},
            onReplyTap: onReplyTap),
        const SizedBox(height: 8),
      ]);
    });
  }
}
