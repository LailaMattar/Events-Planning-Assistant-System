import 'package:event_planning/models/log_out.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/cupertino.dart';

class LogOutRepo{
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<LogOut> logOutUser()async{
    final response = await _helper.get('api/user/logout');
    debugPrint('the log out user body is $response');
    return LogOut.fromJson(response);
  }

  Future<LogOut> logOutVendor()async{
    final response = await _helper.get('api/vendor/logout');
    debugPrint('the log out vendor body is $response');
    return LogOut.fromJson(response);
  }

  Future<LogOut> logOutHall()async{
    final response = await _helper.get('api/hall/logout');
    debugPrint('the log out hall body is $response');
    return LogOut.fromJson(response);
  }
}