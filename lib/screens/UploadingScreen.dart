import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ImagePickerProvider.dart';

class UploadingScreen extends StatelessWidget {
  const UploadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImagePickerProvider imagePickerProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Image.file(File(imagePickerProvider.chosenImage.path))],
        ),
      ),
    );
  }
}
