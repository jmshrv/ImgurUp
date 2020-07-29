import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:imgur/imgur.dart' as imgur;

import '../models/ImagePickerProvider.dart';
import '../components/getImgurApiKey.dart';

class UploadingScreen extends StatefulWidget {
  const UploadingScreen({Key key}) : super(key: key);

  @override
  _UploadingScreenState createState() => _UploadingScreenState();
}

class _UploadingScreenState extends State<UploadingScreen> {
  Future uploadImageFuture;

  Future<imgur.Image> _uploadImageFromProvider() async {
    ImagePickerProvider imagePickerProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);

    Uint8List imageBinary = await imagePickerProvider.chosenImage.readAsBytes();
    String imageBase64 = base64Encode(imageBinary);

    var imgurClient =
        imgur.Imgur(imgur.Authentication.fromClientId(getImgurApiKey()));

    imgur.Image uploadedImage =
        await imgurClient.image.uploadImage(imageBase64: imageBase64);

    return uploadedImage;
  }

  @override
  void initState() {
    super.initState();

    uploadImageFuture = _uploadImageFromProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: uploadImageFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Uploading Image..."),
                      Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                      CircularProgressIndicator(),
                    ],
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  Clipboard.setData(ClipboardData(text: snapshot.data.link));
                  return Text("URL copied to clipboard!");
                } else {
                  return Text("Connection state: ${snapshot.connectionState}");
                }
              })),
    );
  }
}
