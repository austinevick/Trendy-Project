import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/provider/blog_provider.dart';
import 'package:client/view/auth/auth_state_notifier.dart';
import 'package:client/view/widget/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/enum.dart';
import '../../model/auth/user_post_model.dart';
import '../widget/video_player_widget.dart';

class UserPosts extends ConsumerWidget {
  const UserPosts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authProvider).value;
    return ref.watch(userBlogFutureProvider(userId!)).when(
        data: (data) => ListView.builder(
            itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => {},
                    child: Container(
                      child: Text(data[i].content),
                    ),
                  ),
                ),
            itemCount: data.length),
        error: (e, t) => CustomErrorWidget(
            onPressed: () => ref.invalidate(userBlogFutureProvider(userId))),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }

  Widget buildMediaWidget(
      MediaType type, double aspectRatio, UserPostModelData data) {
    switch (type) {
      case MediaType.image:
        return CachedNetworkImage(imageUrl: data.mediaUrl);
      case MediaType.video:
        return VideoPlayerWidget(
            aspectRatio: aspectRatio, videoFromUrl: data.mediaUrl);
      case MediaType.none:
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }
}
