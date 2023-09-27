import 'dart:io';

import 'package:client/view/home/blog_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/enum.dart';
import '../../common/utils.dart';
import '../profile/user_drawer.dart';
import '../widget/custom_button.dart';
import '../widget/custom_error_widget.dart';
import '../widget/profile_image.dart';
import '../blog_detail/blog_detail_view.dart';
import '../../provider/blog_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Consumer(builder: (context, ref, _) {
      return Scaffold(
        drawer: const UserDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leadingWidth: 57,
          leading: GestureDetector(
            onTap: () => scaffoldKey.currentState!.openDrawer(),
            child: const Padding(
              padding: EdgeInsets.only(left: 12, top: 5, bottom: 4),
              child: ProfileImage(),
            ),
          ),
          title: SearchAnchor(
              builder: (ctx, ctrl) => CustomButton(
                    height: 35,
                    onPressed: () => ctrl.openView(),
                    color: primaryLightColor,
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Search', style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(5, (int index) {
                  final String item = 'item $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      controller.closeView(item);
                    },
                  );
                });
              }),
          actions: [
            IconButton(
                color: Colors.grey.shade700,
                onPressed: () {},
                icon: const Icon(Icons.message))
          ],
        ),
        key: scaffoldKey,
        body: SafeArea(
            child: ref.watch(blogsFutureProvider).when(
                data: (data) => RefreshIndicator(
                      onRefresh: () => ref.refresh(blogProvider).fetchBlog(),
                      child: ListView.separated(
                        itemCount: data.length,
                        itemBuilder: (ctx, i) =>
                            data[i].mediaType == MediaType.video &&
                                    Platform.isWindows
                                ? const SizedBox.shrink()
                                : BlogList(
                                    data: data[i],
                                    onPressed: () => push(BlogDetailView(
                                      id: data[i].id,
                                      autoFocus: false,
                                    )),
                                  ),
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(thickness: 10, color: Colors.grey[200]),
                      ),
                    ),
                error: (e, t) => CustomErrorWidget(
                      onPressed: () => ref.refresh(blogsFutureProvider),
                    ),
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ))),
      );
    });
  }
}
