import 'package:client/common/utils.dart';
import 'package:client/view/auth/auth_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/comment_provider.dart';
import '../dialogs/confirm_dialog.dart';

class CommentActionBottomSheet extends StatefulWidget {
  final String commentId;
  final String posterId;
  const CommentActionBottomSheet(
      {super.key, required this.commentId, required this.posterId});

  @override
  State<CommentActionBottomSheet> createState() =>
      _CommentActionBottomSheetState();
}

class _CommentActionBottomSheetState extends State<CommentActionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
    return Consumer(
      builder: (context, ref, child) {
        final userId = ref.watch(authProvider).value;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.share_outlined),
              title: const Text('Share', style: style),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.bookmark_outline),
              title: const Text('Bookmark', style: style),
            ),
            userId != widget.posterId
                ? const SizedBox.shrink()
                : ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.edit_outlined),
                    title: const Text('Edit post', style: style),
                  ),
            userId != widget.posterId
                ? const SizedBox.shrink()
                : ListTile(
                    onTap: () async {
                      final result = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => const ConfirmDialog(
                                title: 'Delete Comment',
                                content:
                                    'Are you sure you want to delete this post, this action cannot be undone.',
                              ));
                      if (result!) {
                        ref
                            .read(commentProvider)
                            .deleteComment(widget.commentId);
                        pop();
                      }
                    },
                    leading: const Icon(Icons.delete_outline),
                    title: const Text('Delete comment', style: style),
                  ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
