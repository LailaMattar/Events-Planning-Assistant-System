class LogOut{
  late bool status = false;

  LogOut.fromJson(Map<String , dynamic> json){
    status = json['status'];
  }
}