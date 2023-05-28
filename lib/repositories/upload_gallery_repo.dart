import 'package:event_planning/models/gallery.dart';
import 'package:event_planning/models/post.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/cupertino.dart';

class UploadGalleryRepo{
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Gallery> uploadToGallery(Gallery gallery)async{
    debugPrint('gallery repo');
    final response = await _helper.uploadmultipleimage(gallery.imageFileList,'api/multiple-image-upload');
    return Gallery.fromJson();
  }

  Future<Gallery> uploadToGalleryHall(Gallery gallery)async{
    debugPrint('gallery hall repo');
    final response = await _helper.uploadmultipleimage(gallery.imageFileList,'api/uploadImgHall');
    return Gallery.fromJson();
  }
}