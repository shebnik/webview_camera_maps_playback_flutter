import 'package:flutter/material.dart';
import 'package:webview_camera_maps_playback_flutter/models/movies.dart';
import 'package:webview_camera_maps_playback_flutter/services/fetch_file.dart';
import 'package:webview_camera_maps_playback_flutter/ui/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: fetchFileFromAssets('assets/json/movies.json'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return HomePage(
              movies: Movies.fromJson(snapshot.data),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
