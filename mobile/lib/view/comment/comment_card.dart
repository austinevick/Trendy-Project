import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as t;
import '../../common/utils.dart';
import '../../model/comment/comment_response_data.dart';
import '../reply/reply_view.dart';
import '../widget/bottom_sheets/comment_action_bottom_sheet.dart';
import '../widget/read_more.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, required this.comment});

  final CommentResponseData comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
              height: 40,
              width: 40,
              child: CachedNetworkImage(
                imageUrl: comment.createdBy.imageUrl,
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
                onTap: () => push(ReplyView(comment: comment)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${comment.createdBy.firstName} ${comment.createdBy.lastName}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  comment.createdBy.profession,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                Text(
                                  t.format(comment.createdAt),
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () => showModalBottomSheet(
                                  context: context,
                                  builder: (ctx) => CommentActionBottomSheet(
                                        posterId: comment.createdBy.id,
                                        commentId: comment.id,
                                      )),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.more_vert, size: 20),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        ReadMore(text: comment.comment),
                      ]),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
        ]));
  }
}
