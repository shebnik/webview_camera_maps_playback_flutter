import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:webview_camera_maps_playback_flutter/models/movies.dart';
import 'package:webview_camera_maps_playback_flutter/ui/widgets/video_controls.dart';

class HomePage extends StatefulWidget {
  final Movies movies;

  const HomePage({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Video video;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    video = widget.movies.videos.first;
    // video =
    //     widget.movies.videos[Random().nextInt(widget.movies.videos.length - 1)];
    _controller = VideoPlayerController.network(video.sources.first);
    _controller.initialize().then((value) {
      setState(() {});
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (!kIsWeb) _controller.play();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(video.title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _controller.value.isInitialized
            ? Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    children: [
                      VideoPlayer(_controller),
                      VideoControls(controller: _controller),
                    ],
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}
