import 'package:event_planning/models/signup_vendor.dart';

class SignUpHall{
  late String max_number_of_person;
  late String min_number_of_person;
  late SignUpVendor vendor;

  SignUpHall({required this.max_number_of_person ,required this.min_number_of_person, required this.vendor});

  SignUpHall.fromJson(){
    //fake
  }
}