class GuestInfo {
  late int id;
  late int event_id;
  late String name;
  late String phone_number;

  late String created_at;
  late String updated_at;

  GuestInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    event_id = json['event_id'];
    updated_at = json['updated_at'] ?? '';
    name = json['name'] ?? '';
    phone_number = json['phone_number'] ?? '';
    created_at = json['created_at'] ?? '';
  }
}
