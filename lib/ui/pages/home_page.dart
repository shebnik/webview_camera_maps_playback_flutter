import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  double zoomValue = 3.0;

  late CameraPosition _currentCameraPosition;

  @override
  void initState() {
    super.initState();
    _currentCameraPosition = _kGooglePlex;
    zoomValue = _kGooglePlex.zoom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraMove: (CameraPosition position) {
              _currentCameraPosition = position;
              setState(() {
                zoomValue = position.zoom;
              });
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: _moveUp,
                          icon: const Icon(Icons.arrow_upward),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: _moveLeft,
                              icon: const Icon(Icons.arrow_back),
                            ),
                            IconButton(
                              onPressed: _moveToStart,
                              icon: const Icon(Icons.location_on),
                            ),
                            IconButton(
                              onPressed: _moveRight,
                              icon: const Icon(Icons.arrow_forward),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: _moveDown,
                          icon: const Icon(Icons.arrow_downward),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        // width: 40.0,
                        height: 200.0,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Slider.adaptive(
                            max: 21.0,
                            min: 3.0,
                            value: zoomValue,
                            onChanged: (value) => _zoomTo(value),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: _zoomIn,
                              icon: const Icon(Icons.zoom_in),
                            ),
                            IconButton(
                              onPressed: _zoomOut,
                              icon: const Icon(Icons.zoom_out),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _moveToStart() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  Future<void> _zoomIn() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomIn());
  }

  Future<void> _zoomOut() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomOut());
  }

  Future<void> _zoomTo(double value) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomTo(value));
  }

  Future<void> _moveUp() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(
      _currentCameraPosition.target.latitude + zoomValue * zoomValue * 0.01,
      _currentCameraPosition.target.longitude,
    )));
  }

  Future<void> _moveLeft() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(
      _currentCameraPosition.target.latitude,
      _currentCameraPosition.target.longitude - zoomValue * 0.01,
    )));
  }

  Future<void> _moveRight() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(
      _currentCameraPosition.target.latitude,
      _currentCameraPosition.target.longitude + zoomValue * 0.01,
    )));
  }

  Future<void> _moveDown() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(
      _currentCameraPosition.target.latitude - zoomValue * 0.01,
      _currentCameraPosition.target.longitude,
    )));
  }
}
