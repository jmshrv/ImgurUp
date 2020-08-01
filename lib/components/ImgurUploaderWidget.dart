import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgur/imgur.dart' as imgur;

import '../components/getImgurApiKey.dart';

class ImgurUploaderWidget extends StatefulWidget {
  ImgurUploaderWidget({Key key}) : super(key: key);

  @override
  _ImgurUploaderWidgetState createState() => _ImgurUploaderWidgetState();
}

class _ImgurUploaderWidgetState extends State<ImgurUploaderWidget> {
  Future imgurUploaderWidgetFuture;

  Future<void> _pickAndUploadImage() async {
    final imagePicker = ImagePicker();
    final imgurClient =
        imgur.Imgur(imgur.Authentication.fromClientId(getImgurApiKey()));

    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);
    imgur.Image imgurResponse = await imgurClient.image
        .uploadImage(imageBase64: base64Encode(await pickedFile.readAsBytes()));

    Clipboard.setData(ClipboardData(text: imgurResponse.link));
  }

  @override
  void initState() {
    super.initState();
    imgurUploaderWidgetFuture = _pickAndUploadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: imgurUploaderWidgetFuture,
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Uploading image..."),
                Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                CircularProgressIndicator()
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Link copied to clipboard!"),
                Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                RaisedButton(
                    child: Text("Upload Another"),
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed("/"))
              ],
            );
          } else {
            return Text(snapshot.connectionState.toString());
          }
        },
      ),
    );
  }
}
