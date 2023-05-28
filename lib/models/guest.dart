class Guest {
  late String name;
  late String phone_number;

  Map<String, dynamic> toJsonCreate() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone_number'] = phone_number;
    return data;
  }

  Guest.fromJsonType() {
    //fake
  }
  Guest({required this.name, required this.phone_number});
}
