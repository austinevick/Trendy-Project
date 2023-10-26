import 'package:client/view/widget/profile_image.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";
import 'package:intl/intl.dart';

class MessageScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String userId;
  final String image;
  const MessageScreen(
      {super.key,
      required this.firstName,
      required this.userId,
      required this.image,
      required this.lastName});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 280,
          leading: Row(
            children: [
              const BackButton(),
              ProfileImage(
                image: widget.image,
              ),
              const SizedBox(width: 8),
              Text(
                "${widget.firstName} ${widget.lastName}",
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          )),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
                slivers: groupByDate.entries
                    .map(
                      (messages) => SliverMainAxisGroup(slivers: [
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: HeaderDelegate(DateFormat.yMMMd()
                              .format(DateTime.parse(messages.key))),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          sliver: SliverList.separated(
                            itemBuilder: (_, int i) => Column(
                              crossAxisAlignment: messages.value[i].isMe
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: messages.value[i].isMe
                                        ? Colors.purple[50]
                                        : const Color(0xffd7d7d7),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 50),
                                        child: Text(messages.value[i].message),
                                      ),
                                      Text(
                                        TimeOfDay.fromDateTime(DateTime.parse(
                                                messages.value[i].time))
                                            .format(context),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Color(0xff155332)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            separatorBuilder: (_, __) =>
                                const SizedBox.shrink(),
                            itemCount: messages.value.length,
                          ),
                        ),
                      ]),
                    )
                    .toList()),
          ),
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0.5, color: Color(0xff999999)))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Send a message',
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  )),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.send))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget getDecoratedSliverList(int itemCount) {
  return DecoratedSliver(
    decoration: BoxDecoration(
      color: Colors.purple[50],
      borderRadius: const BorderRadius.all(Radius.circular(20)),
    ),
    sliver: SliverList.separated(
      itemBuilder: (_, int index) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('Item $index'),
      ),
      separatorBuilder: (_, __) => const Divider(indent: 8, endIndent: 8),
      itemCount: itemCount,
    ),
  );
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  const HeaderDelegate(this.title);
  final String title;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.purple[100],
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(title),
          )),
    );
  }

  @override
  double get maxExtent => minExtent;

  @override
  double get minExtent => 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

var groupByDate = groupBy(messages, (obj) => obj.time);
final messages = <Messages>[
  Messages(1, '2020-06-16T10:31:12.000Z', 'Hello dear', false),
  Messages(1, '2020-07-16T10:30:35.000Z', 'Good morning from here', true),
  Messages(1, '2020-07-14T09:41:18.000Z', 'How are doing?', true),
  Messages(1, '2020-06-15T09:41:18.000Z', 'Am fine dear', false),
  Messages(1, '2020-06-16T10:31:12.000Z', 'Hello dear', false),
  Messages(1, '2020-06-16T10:29:35.000Z', 'Good morning dear', true),
  Messages(1, '2020-06-15T09:41:18.000Z', 'How are doing?', true),
  Messages(1, '2020-06-15T09:41:18.000Z', 'Am fine dear', false),
  Messages(1, '2020-06-16T10:31:12.000Z', 'Hello dear', false),
  Messages(1, '2020-06-16T10:29:35.000Z', 'Good morning dear', true),
  Messages(1, '2020-06-15T09:41:18.000Z', 'How are doing?', true),
  Messages(1, '2023-08-15T09:41:18.000Z', 'Am fine dear', false),
];

class Messages {
  final int id;
  final String time;
  final String message;
  final bool isMe;

  Messages(this.id, this.time, this.message, this.isMe);
}

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat('MMMM dd, y');
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
