import 'package:image_picker/image_picker.dart';

class ImagePickerProvider {
  PickedFile chosenImage;

  Future<void> pickImage() async {
    ImagePicker picker = ImagePicker();
    chosenImage = await picker.getImage(source: ImageSource.gallery);
  }
}
