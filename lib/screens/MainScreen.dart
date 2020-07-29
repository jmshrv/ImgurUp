import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> _prepareImage() async {
    ImagePicker picker = ImagePicker();

    PickedFile image = await picker.getImage(source: ImageSource.gallery);

    print(image.readAsString());
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => _prepareImage(),
            ),
          ),
        ),
      ),
    );
  }
}
