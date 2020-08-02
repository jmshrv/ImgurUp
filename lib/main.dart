import 'package:flutter/material.dart';

import 'screens/MainScreen.dart';
import 'screens/UploadingScreen.dart';

void main() {
  runApp(
    ImgurUp(),
  );
}

class ImgurUp extends StatelessWidget {
  const ImgurUp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Imgur's shade of green (taken from inspect elementing the upload button on imgur.com)
    final imgurGreen = Color.fromARGB(255, 27, 183, 110);

    return MaterialApp(
      routes: {
        "/": (context) => MainScreen(),
        "/uploading": (context) => UploadingScreen()
        // "/uploaded": (context) => UploadedScreen()
      },
      initialRoute: "/",
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: imgurGreen,
        buttonColor: imgurGreen,
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}
