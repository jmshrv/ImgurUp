import 'package:flutter/material.dart';

import '../components/ImgurUploaderWidget.dart';

class UploadingScreen extends StatelessWidget {
  const UploadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ImgurUploaderWidget(),
      ),
    );
  }
}
