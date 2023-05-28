import 'package:event_planning/models/signup_user.dart';

class SignUpVendor{
  late SignUpUser user;
  late String phone_number;
  late String period_of_book;
  late String about;
  late String city;
  late String since;
  late String to;
  late String type;

  SignUpVendor({required this.since,required this.period_of_book,required this.city,
    required this.phone_number,required this.type,required this.to,required this.user});

  SignUpVendor.fromJson(){
    //fake
  }
}