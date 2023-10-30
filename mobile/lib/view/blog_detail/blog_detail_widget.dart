import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/enum.dart';
import '../../common/utils.dart';
import '../../model/blog/blog_response_data.dart';
import '../../provider/blog_provider.dart';
import 'package:timeago/timeago.dart' as t;

import '../auth/auth_state_notifier.dart';
import '../widget/custom_icon_button.dart';
import '../widget/read_more.dart';
import '../widget/video_player_widget.dart';

class BlogDetailWidget extends StatefulWidget {
  final BlogResponseData data;
  final VoidCallback? onPressed;
  final VoidCallback? onCommentTap;
  const BlogDetailWidget(
      {super.key, required this.data, this.onPressed, this.onCommentTap});

  @override
  State<BlogDetailWidget> createState() => _BlogDetailWidgetState();
}

class _BlogDetailWidgetState extends State<BlogDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final userId = ref.watch(authProvider).value;
      return InkWell(
        onTap: widget.onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CachedNetworkImage(
                        imageUrl: widget.data.author.imageUrl,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                          child: Icon(Icons.person_outline),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.data.author.lastName} ${widget.data.author.firstName}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        widget.data.author.profession,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade800),
                      ),
                      Text(
                        t.format(widget.data.createdAt),
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey),
                      )
                    ],
                  ),
                  const Spacer(),
                  TextButton(onPressed: () {}, child: const Text('Follow'))
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ReadMore(text: widget.data.content),
            ),
            const SizedBox(height: 8),
            buildMediaWidget(widget.data.mediaType, context),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  widget.data.likes.isEmpty
                      ? const SizedBox.shrink()
                      : const Icon(Icons.thumb_up, size: 12),
                  const SizedBox(width: 4),
                  Text(
                    widget.data.likes.isEmpty
                        ? ''
                        : widget.data.likes.length.toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                  const Spacer(),
                  Text(
                    ref.watch(blogProvider).setBlogCommentsText(widget.data),
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            Divider(color: Colors.grey.shade300),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconButton(
                    onPressed: () {
                      ref.read(blogProvider).likeBlog(widget.data.id);
                      Future.delayed(const Duration(milliseconds: 200), () {
                        ref.invalidate(blogFutureProvider(widget.data.id));
                        ref.invalidate(blogsFutureProvider);
                      });
                    },
                    tooltip: 'Like',
                    icon: widget.data.likes.contains(userId)
                        ? Icons.thumb_up
                        : Icons.thumb_up_outlined,
                    color: widget.data.likes.contains(userId)
                        ? primaryLightColor
                        : Theme.of(context).iconTheme.color),
                CustomIconButton(
                    onPressed: widget.onCommentTap!,
                    icon: Icons.comment_outlined,
                    tooltip: 'Comment'),
                CustomIconButton(
                    onPressed: () {},
                    icon: Icons.repeat_outlined,
                    tooltip: 'Repost'),
                CustomIconButton(
                    onPressed: () {},
                    icon: Icons.share_outlined,
                    tooltip: 'Share'),
              ],
            )
          ],
        ),
      );
    });
  }

  Widget buildMediaWidget(MediaType type, BuildContext context) {
    switch (type) {
      case MediaType.image:
        return CachedNetworkImage(imageUrl: widget.data.mediaUrl);
      case MediaType.video:
        return VideoPlayerWidget(
            aspectRatio: MediaQuery.sizeOf(context).aspectRatio,
            videoFromUrl: widget.data.mediaUrl);
      case MediaType.none:
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }
}
