import 'dart:io';

import 'package:client/common/enum.dart';
import 'package:client/view/widget/custom_button.dart';
import 'package:client/view/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../provider/blog_provider.dart';
import '../widget/profile_image.dart';
import '../widget/video_player_widget.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final content = TextEditingController();
  XFile? image;
  XFile? video;
  MediaType type = MediaType.none;

  Future<void> requestPermission() async {
    await Permission.storage.request();
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() => this.image = image);
  }

  Future<void> pickVideo() async {
    final file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (file == null) return;
    setState(() => video = file);
  }

  bool get isEmpty => image == null && video == null && content.text.isEmpty;

  void createBlog(WidgetRef ref) {
    switch (type) {
      case MediaType.image:
        ref
            .read(blogProvider.notifier)
            .createBlogWithImage(content.text, File(image!.path));
        break;
      case MediaType.video:
        ref
            .read(blogProvider.notifier)
            .createBlogWithVideo(content.text, File(video!.path));
      case MediaType.none:
        ref.read(blogProvider.notifier).createBlogWithText(content.text);
    }
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Scaffold(
        body: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            IconButton(
                                iconSize: 28,
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(Icons.clear)),
                            const SizedBox(width: 15),
                            const ProfileImage(),
                            const Spacer(),
                            CustomButton(
                              color: Colors.indigo,
                              width: 70,
                              height: 40,
                              text: 'Post',
                              textSize: 14,
                              onPressed: isEmpty ? null : () => createBlog(ref),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomTextfield(
                          maxLines: null,
                          showBorder: false,
                          autoFocus: true,
                          controller: content,
                          onChanged: (value) => setState(() {}),
                          hintText: 'What is happening?',
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        const SizedBox(height: 16),
                        image == null && video == null
                            ? const SizedBox.shrink()
                            : buildMediaWidget()
                      ],
                    ),
                  ),
                ),
                image == null && video == null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton(
                              height: 56,
                              width: 56,
                              radius: 100,
                              onPressed: () {
                                setState(() => type = MediaType.image);
                                pickImage();
                              },
                              color: Colors.grey.withOpacity(0.3),
                              child: const Icon(Icons.image),
                            ),
                            CustomButton(
                              height: 56,
                              width: 56,
                              onPressed: () {
                                setState(() => type = MediaType.video);
                                pickVideo();
                              },
                              color: Colors.grey.withOpacity(0.3),
                              radius: 100,
                              child: const Icon(Icons.videocam),
                            )
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            )),
      );
    });
  }

  Widget buildMediaWidget() {
    switch (type) {
      case MediaType.image:
        return Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  fit: BoxFit.cover, image: FileImage(File(image!.path)))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                    height: 55,
                    width: 55,
                    color: Colors.blueGrey,
                    radius: 100,
                    onPressed: () => setState(() => image = null),
                    child: const Icon(Icons.clear, color: Colors.white)),
              ),
            ],
          ),
        );
      case MediaType.video:
        return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                VideoPlayerWidget(
                    aspectRatio: MediaQuery.sizeOf(context).aspectRatio,
                    videoFromFile: video!.path),
                video!.path.isEmpty
                    ? const SizedBox.shrink()
                    : Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomButton(
                              height: 55,
                              width: 55,
                              color: Colors.blueGrey.withOpacity(0.3),
                              radius: 100,
                              onPressed: () => setState(() => video = null),
                              child:
                                  const Icon(Icons.clear, color: Colors.white)),
                        ),
                      ),
              ],
            ));
      default:
        return const SizedBox.shrink();
    }
  }
}
