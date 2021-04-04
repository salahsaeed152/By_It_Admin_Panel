class OrderModel {
  String documentId;
  int totalPrice;
  String address;

  OrderModel({this.documentId, this.totalPrice, this.address});

  OrderModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    documentId = map['documentId'];
    totalPrice = map['TotalPrice'];
    address = map['Address'];
  }

  toJson() {
    return {
      'documentId': documentId,
      'TotalPrice': totalPrice,
      'Address': address,
    };
  }

}