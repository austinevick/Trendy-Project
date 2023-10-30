import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/view/blog_detail/blog_detail_view.dart';
import 'package:client/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/enum.dart';
import '../../common/utils.dart';
import '../../model/blog/blog_response_data.dart';
import '../../provider/blog_provider.dart';
import '../auth/auth_state_notifier.dart';
import '../widget/custom_icon_button.dart';
import '../widget/read_more.dart';
import 'package:timeago/timeago.dart' as t;
import '../widget/video_player_widget.dart';
import '../widget/bottom_sheets/post_action_bottom_sheet.dart';
import '../widget/bottom_sheets/repost_bottom_sheet.dart';

class BlogList extends StatelessWidget {
  final BlogResponseData data;
  final VoidCallback? onPressed;
  const BlogList({super.key, required this.data, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final userId = ref.watch(authProvider).value;

      return InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => push(ProfileScreen(userId: data.author.id)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CachedNetworkImage(
                            imageUrl: data.author.imageUrl,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const CircleAvatar(
                              child: Icon(Icons.person_outline),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${data.author.lastName} ${data.author.firstName}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          data.author.profession,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey.shade800),
                        ),
                        Text(
                          t.format(data.createdAt),
                          style:
                              const TextStyle(fontSize: 13, color: Colors.grey),
                        )
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => showModalBottomSheet(
                                context: context,
                                builder: (ctx) =>
                                    PostActionBottomSheet(data: data)),
                            icon: const Icon(Icons.more_vert)),
                        // userId == data.author.id
                        //     ? const SizedBox.shrink()
                        //     : TextButton.icon(
                        //         icon: Icon(Icons.add),
                        //         onPressed: () {},
                        //         label: const Text('Follow'))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ReadMore(text: data.content),
              ),
              const SizedBox(height: 8),
              buildMediaWidget(data.mediaType, context),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    data.likes.isEmpty
                        ? const SizedBox.shrink()
                        : const Icon(Icons.thumb_up,
                            size: 12, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(
                      data.likes.isEmpty ? '' : data.likes.length.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () =>
                          push(BlogDetailView(id: data.id, autoFocus: true)),
                      child: Text(
                        ref.watch(blogProvider).setBlogListCommentsText(data),
                        style: const TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomIconButton(
                      onPressed: () {
                        ref.read(blogProvider).likeBlog(data.id);
                        Future.delayed(const Duration(milliseconds: 100), () {
                          ref.invalidate(blogFutureProvider(data.id));
                          ref.invalidate(blogsFutureProvider);
                        });
                      },
                      tooltip: 'Like',
                      icon: data.likes.contains(userId)
                          ? Icons.thumb_up
                          : Icons.thumb_up_outlined,
                      color: data.likes.contains(userId)
                          ? primaryLightColor
                          : Theme.of(context).iconTheme.color),
                  CustomIconButton(
                      onPressed: () =>
                          push(BlogDetailView(id: data.id, autoFocus: true)),
                      icon: Icons.comment_outlined,
                      tooltip: 'Comment'),
                  CustomIconButton(
                      onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (ctx) => RepostBottomSheet(data: data)),
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
        ),
      );
    });
  }

  Widget buildMediaWidget(MediaType type, BuildContext context) {
    switch (type) {
      case MediaType.image:
        return CachedNetworkImage(imageUrl: data.mediaUrl);
      case MediaType.video:
        return VideoPlayerWidget(
            aspectRatio: MediaQuery.sizeOf(context).aspectRatio,
            videoFromUrl: data.mediaUrl);
      case MediaType.none:
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }
}
