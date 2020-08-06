import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgur/imgur.dart' as imgur;

import '../components/getImgurApiKey.dart';

class ImgurUploaderWidget extends StatefulWidget {
  ImgurUploaderWidget({Key key, @required this.imageSource}) : super(key: key);

  final String imageSource;

  @override
  _ImgurUploaderWidgetState createState() => _ImgurUploaderWidgetState();
}

class _ImgurUploaderWidgetState extends State<ImgurUploaderWidget> {
  Future imgurUploaderWidgetFuture;

  // The amount of spacing between the completed message and button
  final verticalPaddingAmount = 8.0;

  Future<String> _pickAndUploadImage(String imageSource) async {
    final imagePicker = ImagePicker();
    final imgurClient =
        imgur.Imgur(imgur.Authentication.fromClientId(getImgurApiKey()));

    PickedFile pickedFile;

    switch (imageSource) {
      case "gallery":
        try {
          pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
        } catch (e) {
          return Future.error(e);
        }
        break;
      case "camera":
        try {
          pickedFile = await imagePicker.getImage(source: ImageSource.camera);
        } catch (e) {
          return Future.error(e);
        }
        break;
      default:
        return Future.error(
            'imageSource must either be "gallery" or "camera". Make sure you\'ve got the right argument when switching to UploadingScreen.');
    }

    Uint8List pickedFileBytes = await pickedFile.readAsBytes();

    if (pickedFileBytes.lengthInBytes > 10485760) {
      // Imgur only allows files up to 10MB (I'm assuming they see a MB as 1024KB since I couldn't find any info online)

      // We calculate the size of the image here and round it to a human-readable level so that we don't have to do a stupidly long one-liner in the Future.error
      double humanReadableSize = double.parse(
          (pickedFileBytes.lengthInBytes / 1048576).toStringAsFixed(2));

      return Future.error(
          "Image size too large. Imgur only allows files up to 10MB. Your image is $humanReadableSize MB.");
    }

    imgur.Image imgurResponse;
    try {
      imgurResponse = await imgurClient.image
          .uploadImage(imageBase64: base64Encode(pickedFileBytes));
    } catch (e) {
      return Future.error(e);
    }

    Clipboard.setData(ClipboardData(text: imgurResponse.link));
    return imgurResponse.link;
  }

  @override
  void initState() {
    super.initState();
    imgurUploaderWidgetFuture = _pickAndUploadImage(widget.imageSource);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: imgurUploaderWidgetFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // If the snapshot completes with data, we're assuming that the function completed successfully and the image is uploaded
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, size: 48),
                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: verticalPaddingAmount)),
                Text(
                  "Link copied to clipboard!",
                  textAlign: TextAlign.center,
                ),
                RaisedButton(
                  child: Text("Start Again"),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed("/"),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 48),
                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: verticalPaddingAmount)),
                Text(
                  "An error has occured: ${snapshot.error.toString()}",
                  textAlign: TextAlign.center,
                ),
                RaisedButton(
                  child: Text("Start Again"),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed("/"),
                )
              ],
            );
          } else {
            // If the snapshot doesn't have data or an error, it's probably still uploading
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
