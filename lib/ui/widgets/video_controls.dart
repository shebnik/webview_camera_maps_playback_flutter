import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_camera_maps_playback_flutter/ui/widgets/play_pause_widget.dart';
import 'package:webview_camera_maps_playback_flutter/ui/widgets/video_slider.dart';

class VideoControls extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoControls({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _VideoControlsState createState() => _VideoControlsState();
}

class _VideoControlsState extends State<VideoControls> {
  late final VideoPlayerController _controller;

  ValueNotifier<bool> isPlaying = ValueNotifier(false);
  bool controlsShown = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _handleTap(),
      child: Visibility(
        visible: controlsShown,
        replacement: const SizedBox.expand(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: VideoSlider(controller: _controller),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 50,
                    onPressed: () => _handleVideo(-10),
                    icon: const Icon(
                      Icons.replay_10,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ClipOval(
                    child: InkWell(
                      onTap: _handlePause,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isPlaying,
                        builder: (context, value, _) =>
                            PlayPauseWidget(isPlaying: value),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    iconSize: 50,
                    onPressed: () => _handleVideo(10),
                    icon: const Icon(
                      Icons.forward_10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap() {
    setState(() {
      controlsShown = !controlsShown;
    });
  }

  void _handlePause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      isPlaying.value = false;
    } else {
      _controller.play();
      isPlaying.value = true;
      if (controlsShown) {
        Timer(const Duration(seconds: 2), () {
          if (controlsShown) setState(() => controlsShown = false);
        });
      }
    }
  }

  void _handleVideo(int seconds) {
    _controller.seekTo(
      Duration(seconds: _controller.value.position.inSeconds + seconds),
    );
  }

  void _sliderChanged(double value) {}
}
