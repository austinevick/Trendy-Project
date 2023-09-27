import 'dart:io';

import 'package:client/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String? videoFromUrl;
  final String? videoFromFile;
  final double? aspectRatio;
  const VideoPlayerWidget(
      {super.key, this.videoFromUrl, this.videoFromFile, this.aspectRatio});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController controller;
  late final AnimationController animationController;
  late final Animation<double> animation;
  void init() {
    if (widget.videoFromFile == null) {
      controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoFromUrl!));
    } else {
      controller = VideoPlayerController.file(File(widget.videoFromFile!));
    }
  }

  @override
  void initState() {
    init();
    controller..initialize();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();

    super.initState();
  }

  void onVideoTap() {
    if (controller.value.isPlaying) {
      animationController.reverse();
      controller.play();
    } else {
      animationController.forward();
      controller.pause();
    }
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onVideoTap(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
              aspectRatio: widget.aspectRatio ?? controller.value.aspectRatio,
              child: VideoPlayer(controller)),
          !controller.value.isInitialized
              ? const SizedBox.shrink()
              : ScaleTransition(
                  scale: animation,
                  child: Center(
                      child: CircleAvatar(
                          backgroundColor: primaryLightColor.withOpacity(0.5),
                          radius: 35,
                          child: Icon(
                              controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 40))),
                )
        ],
      ),
    );
  }
}
