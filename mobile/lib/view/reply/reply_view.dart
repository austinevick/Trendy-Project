import 'package:client/model/reply/reply_model.dart';
import 'package:client/provider/reply_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/utils.dart';
import '../../model/comment/comment_response_data.dart';
import '../comment/comment_card.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';
import '../widget/profile_image.dart';
import 'reply_card.dart';

class ReplyView extends StatefulWidget {
  final CommentResponseData comment;
  const ReplyView({super.key, required this.comment});

  @override
  State<ReplyView> createState() => _ReplyViewState();
}

class _ReplyViewState extends State<ReplyView> {
  final commentCtrl = TextEditingController();
  final focusNode = FocusNode();
  final provider = ReplyProvider();
  List<ReplyResponseData> replies = [];

  void initComments(String id) async {
    final data = await provider.getRepliesByCommentId(id);
    setState(() => replies = data);
  }

  @override
  void initState() {
    initComments(widget.comment.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  CommentCard(comment: widget.comment),
                  const SizedBox(height: 12),
                  Column(
                      children: replies
                          .map((reply) => Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: ReplyCard(
                                  reply: reply,
                                  onLikeTap: () {},
                                  onReplyTap: () {},
                                ),
                              ))
                          .toList()
                          .reversed
                          .toList()),
                ],
              ),
            ),
            Container(color: Colors.grey, width: double.infinity, height: 1.5),
            CustomTextfield(
                controller: commentCtrl,
                maxLines: null,
                showBorder: false,
                focusNode: focusNode,
                fontWeight: FontWeight.normal,
                hintText: 'Leave your thought here',
                onChanged: (value) => setState(() {}),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(height: 35, width: 35, child: ProfileImage()),
                )),
            AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: commentCtrl.text.isEmpty
                    ? const SizedBox.shrink()
                    : Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8, bottom: 10),
                          child: CustomButton(
                            width: 68,
                            height: 35,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              provider.replyToComment(
                                  commentCtrl.text.trim(), widget.comment.id);

                              Future.delayed(const Duration(milliseconds: 800),
                                  () {
                                initComments(widget.comment.id);
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
      );
    });
  }
}
