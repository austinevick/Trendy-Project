import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final VoidCallback onTap;
  final String? image;
  final String? imageFile;
  final IconData? icon;
  final double? iconSize;
  final bool isSelected;
  final bool showIcon;
  const UserAvatar(
      {super.key,
      required this.onTap,
      this.image,
      this.isSelected = false,
      this.showIcon = false,
      this.imageFile,
      this.icon,
      this.iconSize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      radius: 100,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          isSelected
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    File(imageFile!),
                    height: 115,
                    width: 115,
                    fit: BoxFit.cover,
                  ))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                      imageUrl: image!,
                      height: 115,
                      width: 115,
                      errorWidget: (context, url, error) => CircleAvatar(
                            child: Icon(Icons.person_outline, size: iconSize),
                          ),
                      fit: BoxFit.cover)),
          showIcon
              ? Positioned(
                  right: -4,
                  bottom: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.black,
                      child: Icon(icon, color: Colors.white),
                    ),
                  ))
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
