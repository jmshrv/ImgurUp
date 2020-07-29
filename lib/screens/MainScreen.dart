import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ImagePickerProvider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  double _calculateButtonSize(BuildContext context) {
    // We can't just use the screen width to resize the button because if the screen is landscape, the button won't look right.

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (height >= width) {
      return width * 0.9;
    } else {
      return height * 0.9;
    }
  }

  @override
  Widget build(BuildContext context) {
    ImagePickerProvider imagePickerProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Semantics(
          button: true,
          label: "Upload",
          child: Ink(
            decoration:
                ShapeDecoration(shape: CircleBorder(), color: Colors.lightBlue),
            child: IconButton(
              icon: Icon(
                Icons.file_upload,
                color: Colors.white,
              ),
              iconSize: _calculateButtonSize(context),
              onPressed: () {
                imagePickerProvider.pickImage().then(
                      (_) => Navigator.of(context)
                          .pushReplacementNamed("/uploading"),
                    );
              },
            ),
          ),
        ),
      ),
    );
  }
}
