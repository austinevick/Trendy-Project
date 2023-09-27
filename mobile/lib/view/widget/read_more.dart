import 'package:flutter/material.dart';

class ReadMore extends StatefulWidget {
  final String text;

  const ReadMore({super.key, required this.text});

  @override
  State<ReadMore> createState() => _ReadMoreState();
}

class _ReadMoreState extends State<ReadMore> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return flag
        ? InkWell(
            onTap: () => setState(() => flag = !flag),
            child: Text(
              widget.text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        : Text(
            widget.text,
          );
  }
}
