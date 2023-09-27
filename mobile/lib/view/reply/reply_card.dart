import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/model/reply/reply_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as t;
import '../widget/bottom_sheets/comment_action_bottom_sheet.dart';
import '../widget/custom_text_button.dart';
import '../widget/read_more.dart';

class ReplyCard extends StatelessWidget {
  final ReplyResponseData reply;
  final VoidCallback onReplyTap;
  final VoidCallback onLikeTap;
  const ReplyCard(
      {super.key,
      required this.reply,
      required this.onReplyTap,
      required this.onLikeTap});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CachedNetworkImage(
                      imageUrl: reply.repliedBy.imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(Icons.person_outline),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Material(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${reply.repliedBy.firstName} ${reply.repliedBy.lastName}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        reply.repliedBy.profession,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                      Text(
                                        t.format(reply.createdAt),
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(100),
                                    onTap: () => showModalBottomSheet(
                                        context: context,
                                        builder: (ctx) =>
                                            CommentActionBottomSheet(
                                              posterId: reply.id,
                                              commentId: reply.repliedBy.id,
                                            )),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.more_vert, size: 20),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5),
                              ReadMore(text: reply.reply),
                            ]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ]),
              CustomTextButton(
                  likes: reply.likes,
                  replies: [],
                  onLikeTap: onLikeTap,
                  onReplyTap: onReplyTap)
            ],
          ));
    });
  }
}
