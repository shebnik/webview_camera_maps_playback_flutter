import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class AppGallery extends StatelessWidget {
  const AppGallery({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<XFile> images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images gallery'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: images
              .map((e) => Image.file(
                    File(e.path),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
