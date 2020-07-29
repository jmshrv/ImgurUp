import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/MainScreen.dart';
import 'screens/UploadingScreen.dart';

import 'models/ImagePickerProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ImagePickerProvider>(
          create: (_) => ImagePickerProvider(),
        )
      ],
      child: ImgurUp(),
    ),
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
