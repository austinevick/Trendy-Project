import 'package:client/common/utils.dart';
import 'package:client/provider/blog_provider.dart';
import 'package:client/view/widget/custom_button.dart';
import 'package:client/view/widget/custom_textfield.dart';
import 'package:client/view/widget/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/comment/comment_response_data.dart';
import '../../provider/comment_provider.dart';
import '../comment/comment_list.dart';
import 'blog_detail_widget.dart';

class BlogDetailView extends StatefulWidget {
  final String id;
  final bool autoFocus;
  const BlogDetailView({super.key, required this.id, required this.autoFocus});

  @override
  State<BlogDetailView> createState() => _BlogDetailViewState();
}

class _BlogDetailViewState extends State<BlogDetailView> {
  final commentCtrl = TextEditingController();
  final focusNode = FocusNode();
  final provider = CommentProvider();
  List<CommentResponseData> comments = [];

  void initComments(String id) async {
    final data = await provider.getCommentByBlogId(id);
    setState(() => comments = data);
  }

  @override
  void initState() {
    initComments(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Scaffold(
          appBar: AppBar(),
          body: ref.watch(blogFutureProvider(widget.id)).when(
              data: (data) => SafeArea(
                      child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BlogDetailWidget(
                                data: data,
                                onCommentTap: () => FocusScope.of(context)
                                    .requestFocus(focusNode),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Text(
                                  'Comments',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(height: 20),
                              comments.isEmpty
                                  ? Center(
                                      child: Text(
                                        'Be the first to comment',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey.shade400),
                                      ),
                                    )
                                  : Column(
                                      children: comments
                                          .map((e) => CommentList(
                                              comment: e,
                                              onReplyTap: () {
                                                // ref
                                                //     .watch(commentProvider)
                                                //     .likeComment(e.id);
                                                // Future.delayed(
                                                //     const Duration(
                                                //         milliseconds: 1000),
                                                //     () => initComments(
                                                //         widget.id));
                                              }))
                                          .toList()
                                          .reversed
                                          .toList()),
                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          color: Colors.grey,
                          width: double.infinity,
                          height: 1.5),
                      CustomTextfield(
                          controller: commentCtrl,
                          maxLines: null,
                          autoFocus: widget.autoFocus,
                          showBorder: false,
                          focusNode: focusNode,
                          fontWeight: FontWeight.normal,
                          hintText: 'Leave your thought here',
                          onChanged: (value) => setState(() {}),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                                height: 35, width: 35, child: ProfileImage()),
                          )),
                      AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: commentCtrl.text.isEmpty
                              ? const SizedBox.shrink()
                              : Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, bottom: 10),
                                    child: CustomButton(
                                      width: 68,
                                      height: 35,
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        provider.postComment(
                                            commentCtrl.text.trim(), widget.id);

                                        Future.delayed(
                                            const Duration(milliseconds: 800),
                                            () {
                                          initComments(widget.id);
                                          ref.invalidate(
                                              blogFutureProvider(widget.id));
                                          ref.invalidate(blogsFutureProvider);
                                        });
                                        commentCtrl.clear();
                                      },
                                      color: primaryLightColor,
                                      text: 'Post',
                                    ),
                                  ),
                                )),
                    ],
                  )),
              error: (e, t) => Text(e.toString()),
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  )));
    });
  }
}
