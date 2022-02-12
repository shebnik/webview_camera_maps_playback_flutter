import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoSlider extends StatefulWidget {
  final VideoPlayerController controller;
  const VideoSlider({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _VideoSliderState createState() => _VideoSliderState();
}

class _VideoSliderState extends State<VideoSlider> {
  _VideoSliderState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  late VoidCallback listener;

  VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.value.isInitialized) {
      final int duration = controller.value.duration.inMilliseconds;
      final int position = controller.value.position.inMilliseconds;

      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 32,
            child: Slider.adaptive(
              value: position / duration,
              activeColor: const Color.fromRGBO(255, 0, 0, 1),
              onChanged: (double value) =>
                  controller.seekTo(controller.value.duration * value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(controller.value.position),
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  formatDuration(controller.value.duration),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  static String formatDuration(Duration d) {
    String sDuration =
        "${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(d.inSeconds.remainder(60).toString().padLeft(2, '0'))}";
    if (d.inHours > 0) {
      sDuration = d.inHours.toString().padLeft(2, '0') + ':$sDuration';
    }
    return sDuration;
  }
}
