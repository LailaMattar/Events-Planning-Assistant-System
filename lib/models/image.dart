import 'package:flutter/cupertino.dart';

class ImageGallery{
  late int id;
  late String imagePath;

  ImageGallery.fromJson(Map<String, dynamic> json){
    id = json['id'];
    imagePath = json['title'];
    debugPrint('title : $imagePath + $id');
  }
}