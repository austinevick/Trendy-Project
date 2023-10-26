import 'package:client/common/utils.dart';
import 'package:client/view/profile/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/user_profile_provider.dart';
import '../auth/auth_state_notifier.dart';
import '../widget/custom_error_widget.dart';
import 'edit_profile.dart';
import 'user_posts.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;

  const ProfileScreen({super.key, required this.userId});
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final currentUserId = ref.watch(authProvider).value;

      return DefaultTabController(
        length: 2,
        child: Scaffold(
            body: ref.watch(userDataProvider).when(
                data: (data) => NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                          SliverAppBar(
                              title: const Text('Profile'),
                              bottom: PreferredSize(
                                  preferredSize: const Size(100, 270),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      UserAvatar(
                                        image: data.imageUrl,
                                        showIcon: userId == currentUserId
                                            ? true
                                            : false,
                                        onTap: () =>
                                            push(EditProfile(data: data)),
                                        icon: Icons.edit_outlined,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "${data.firstName} ${data.lastName}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        data.profession!,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      data.about!.isEmpty
                                          ? const SizedBox.shrink()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Text(
                                                data.about!,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          buildText('Followers',
                                              "${data.followers.length}"),
                                          buildText('Following',
                                              '${data.following.length}'),
                                          buildText('Posts', '125'),
                                        ],
                                      )
                                    ],
                                  ))),
                          SliverPersistentHeader(
                              pinned: true,
                              delegate: TabbarDelegate(
                                toolBarHeight: 50,
                                child: const TabBar(
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    tabs: [
                                      Tab(text: 'Post'),
                                      Tab(text: 'Saved'),
                                    ]),
                              ))
                        ],
                    body: const TabBarView(children: [
                      UserPosts(),
                      Center(
                        child: Text('Saved posts'),
                      )
                    ])),
                error: (e, t) => Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: CustomErrorWidget(
                        onPressed: () => ref.refresh(userDataProvider),
                      ),
                    ),
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ))),
      );
    });
  }

  Widget buildText(String title, String value) => Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              )),
        ],
      );
}

class TabbarDelegate extends SliverPersistentHeaderDelegate {
  double toolBarHeight;
  Widget child;

  TabbarDelegate({
    required this.toolBarHeight,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      child: SizedBox(height: toolBarHeight, child: child),
    );
  }

  @override
  double get maxExtent => toolBarHeight;

  @override
  double get minExtent => toolBarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
