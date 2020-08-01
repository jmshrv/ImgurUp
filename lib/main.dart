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
    return MaterialApp(
      routes: {
        "/": (context) => MainScreen(),
        "/uploading": (context) => UploadingScreen()
        // "/uploaded": (context) => UploadedScreen()
      },
      initialRoute: "/",
    );
  }
}
