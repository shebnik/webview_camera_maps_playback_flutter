import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class AppCamera extends StatelessWidget {
  final CameraController? controller;
  final void Function(XFile image) addImage;

  const AppCamera({
    Key? key,
    required this.controller,
    required this.addImage,
  }) : super(key: key);

  Future<void> _takePicture() async {
    XFile? image = await controller?.takePicture();
    if (image != null) addImage(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera preview'),
        centerTitle: true,
      ),
      body: controller?.value.isInitialized == true
          ? Center(
              child: SizedBox.expand(
                child: CameraPreview(controller!),
              ),
            )
          : const SizedBox(),
      floatingActionButton: controller?.value.isInitialized == true
          ? FloatingActionButton(
              onPressed: _takePicture,
              child: const Icon(Icons.camera),
            )
          : null,
    );
  }
}
