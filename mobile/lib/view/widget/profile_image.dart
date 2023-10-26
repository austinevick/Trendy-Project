import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/user_profile_provider.dart';

class ProfileImage extends StatelessWidget {
  final String? image;
  const ProfileImage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return ref.watch(userDataProvider).when(
          data: (data) => ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CachedNetworkImage(
                    imageUrl: image ?? data.imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const CircleAvatar(
                      radius: 15,
                      child: Icon(Icons.person_outline),
                    ),
                  ),
                ),
              ),
          error: (e, t) => const CircleAvatar(
                radius: 23,
                child: Icon(Icons.person_outline),
              ),
          loading: () => const SizedBox.shrink());
    });
  }
}
