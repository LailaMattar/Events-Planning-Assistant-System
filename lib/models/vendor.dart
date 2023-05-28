class Vendor{
  late int id;
  late String name;
  late String type;
  late String profileThumbnail;

  Vendor({required this.name,required this.profileThumbnail,required this.type});

  Vendor.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    type = json['type'];
    profileThumbnail = json['profile_thumbnail'] ?? ' ';
  }
}