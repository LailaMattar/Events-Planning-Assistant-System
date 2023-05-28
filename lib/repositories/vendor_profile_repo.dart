import 'package:event_planning/models/vendor_profile.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/cupertino.dart';

class VendorProfileRepo{
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<VendorProfile> getProfile()async{
    final response = await _helper.get('api/vendor/showProfile');
    debugPrint('the body is $response');
    return VendorProfile.fromJson(response);
  }

  Future<VendorProfile> getProfileById(int id)async{
    final response = await _helper.get('api/profileVendorById/$id');
    debugPrint('the body is $response');
    return VendorProfile.fromJson(response);
  }

  Future<VendorProfile> getProfileHall()async{
    final response = await _helper.get('api/hall/showHall');
    debugPrint('the body is $response');
    return VendorProfile.fromJsonSala(response);
  }

  Future<VendorProfile> getProfileHallById(int id)async{
    final response = await _helper.get('api/hall/showProfileHall/$id');
    debugPrint('the body is $response');
    return VendorProfile.fromJsonSala(response);
  }
}