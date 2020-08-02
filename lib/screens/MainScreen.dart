import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  double _calculateButtonSize(BuildContext context) {
    // We can't just use the screen width to resize the button because if the screen is landscape, the button won't look right.
    // This function needs the context because MediaQuery needs it.

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
    return Scaffold(
      body: Center(
        child: Semantics(
          button: true,
          label: "Upload",
          child: Container(
            width: _calculateButtonSize(context),
            // No need to calculate height since for this widget, width will always be equal to height.
            child: FittedBox(
              child: FloatingActionButton(
                  child: Icon(
                    Icons.file_upload,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed("/uploading")),
            ),
          ),
        ),
      ),
    );
  }
}
