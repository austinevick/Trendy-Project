import 'package:client/common/utils.dart';
import 'package:client/provider/blog_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/auth_state_notifier.dart';
import '../dialogs/confirm_dialog.dart';

class PostActionBottomSheet extends StatefulWidget {
  final String blogId;
  final String posterId;
  const PostActionBottomSheet(
      {super.key, required this.blogId, required this.posterId});

  @override
  State<PostActionBottomSheet> createState() => _PostActionBottomSheetState();
}

class _PostActionBottomSheetState extends State<PostActionBottomSheet> {
  bool deletePost = false;
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
                                title: 'Delete Post',
                                content:
                                    'Are you sure you want to delete this post, this action cannot be undone.',
                              ));
                      if (result!) {
                        ref.read(blogProvider).deleteBlog(widget.blogId);
                        pop();
                      }
                    },
                    leading: const Icon(Icons.delete_outline),
                    title: const Text('Delete post', style: style),
                  ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
