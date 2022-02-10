import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:webview_camera_maps_playback_flutter/ui/tabs/app_camera.dart';
import 'package:webview_camera_maps_playback_flutter/ui/tabs/app_gallery.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  ValueNotifier<int> currentTabIndex = ValueNotifier(0);

  late List<CameraDescription> cameras;
  CameraController? controller;
  ValueNotifier<List<XFile>> images = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      currentTabIndex.value = tabController.index;
    });
    unawaited(initCamera());
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          key: UniqueKey(),
          controller: tabController,
          children: [
            AppCamera(
              controller: controller,
              addImage: _addImage,
            ),
            ValueListenableBuilder<List<XFile>>(
              valueListenable: images,
              builder: (context, value, _) => AppGallery(images: value),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: currentTabIndex,
        builder: (context, value, _) {
          return BottomNavigationBar(
            onTap: (index) {
              tabController.index = index;
              currentTabIndex.value = index;
            },
            currentIndex: value,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                label: 'Camera',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.image),
                label: 'Gallery',
              ),
            ],
          );
        },
      ),
    );
  }

  void _addImage(XFile image) {
    images.value = [...images.value, image];
  }
}
