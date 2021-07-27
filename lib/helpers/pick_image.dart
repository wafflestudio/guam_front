import 'package:image_picker/image_picker.dart';

Future<PickedFile> pickImage() async {
  final ImagePicker picker = ImagePicker();

  return await picker.getImage(source: ImageSource.gallery);
}
