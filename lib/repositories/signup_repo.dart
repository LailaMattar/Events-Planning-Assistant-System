import 'package:event_planning/models/post.dart';
import 'package:event_planning/models/signup_hall.dart';
import 'package:event_planning/models/signup_user.dart';
import 'package:event_planning/models/signup_vendor.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/cupertino.dart';

class SignUpRepo{
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<SignUpUser> signupUser(SignUpUser signUpUser)async{
    debugPrint('sign up user repo');
    final response = await _helper.uploadImageUser('api/user/register', signUpUser);
    debugPrint("response signup : ${response}");
    return SignUpUser.fromJson();
  }

  Future<SignUpVendor> signupVendor(SignUpVendor signUpVendor)async{
    debugPrint('sign up vendor repo');
    final response = await _helper.uploadImageVendor('api/vendor/register', signUpVendor);
    debugPrint("response signup vendor : ${response}");
    return SignUpVendor.fromJson();
  }

  Future<SignUpHall> signupHall(SignUpHall signUpHall)async{
    debugPrint('sign up hall repo');
    final response = await _helper.uploadImageHall('api/hall/register', signUpHall);
    debugPrint("response signup hall : ${response}");
    return SignUpHall.fromJson();
  }
}