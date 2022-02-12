import 'package:flutter/material.dart';

class PlayPauseWidget extends StatelessWidget {
  final bool isPlaying;

  const PlayPauseWidget({
    Key? key,
    required this.isPlaying,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 100,
      height: 100,
      child: Icon(
        isPlaying ? Icons.pause : Icons.play_arrow,
        size: 50,
      ),
    );
  }
}
