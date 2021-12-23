import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class MediaPickerService {
  // Returns a [File] object pointing to the image that was picked.
  Future<File> pickImage({ImageSource source}) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: source);
    return File(pickedFile.path);
  }

  Future<File> pickGalleryVideo({@required ImageSource source}) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getVideo(source: source);
    return File(pickedFile.path);
  }

  Future<File> pickImageOrVideo() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'mp4', 'mkv', 'mov'],
    );
    if (result != null) {
      return File(result.files.first.path);
    }

    return null;
  }

  Future<File> pickVideo() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'mkv', 'mov'],
    );
    if (result != null) {
      return File(result.files.first.path);
    }

    return null;
  }
}
