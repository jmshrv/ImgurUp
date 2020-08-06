import 'package:flutter/material.dart';

import '../components/ImgurUploaderWidget.dart';

class UploadingScreen extends StatelessWidget {
  const UploadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imageSource = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(
        child: ImgurUploaderWidget(
          imageSource: imageSource,
        ),
      ),
    );
  }
}
