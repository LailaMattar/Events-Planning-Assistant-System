class Adv {
  late int id;
  late String type;
  late String vendorName;
  late String hallName;
  late String copunCode;
  late String image;
  late String created_at;
  late String updated_at;

  Adv.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    print('1');
    updated_at = json['updated_at'] ?? '';
    print('2');
    created_at = json['created_at'] ?? '';
    print('');
    copunCode = json['copunCode'] ?? " ";
    print('4');
    hallName = json['hallName'] ?? " ";
    print('5');
    vendorName = json['vendorName'] ?? " ";
    print('6');
    type = json['type'] ?? " ";
    print('7');
    image = json['image'] ?? " ";
  }
}
