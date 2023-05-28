import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Gallery{
  late List<XFile> imageFileList = [];
  late List<dynamic> documents = [];

  Gallery.fromJson(){}

  Gallery({required this.imageFileList});
}