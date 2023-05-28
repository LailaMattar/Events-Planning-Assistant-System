class VendorName {
  String hallName;
  String vendorName;

  VendorName({required this.hallName, required this.vendorName});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hallName == "") {
      data['hallName'] = null;
    } else {
      data['hallName'] = hallName;
    }
    if (vendorName == '') {
      data['vendorName'] = null;
    } else {
      data['vendorName'] = vendorName;
    }
    return data;
  }
}
