class CartDataModel {
  int? id;
  String? productName;
  String? modelNumber;
  String? price;
  String? manufactureDate;
  String? manufactureAddress;
  String? productType;

  CartDataModel(
      {this.id,
      this.productName,
      this.modelNumber,
      this.price,
      this.manufactureDate,
      this.manufactureAddress,
      this.productType});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productName'] = productName;
    data['modelNumber'] = modelNumber;
    data['price'] = price;
    data['manufactureDate'] = manufactureDate;
    data['manufactureAddress'] = manufactureAddress;
    data['productType'] = productType;
    return data;
  }

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    return CartDataModel(
      id: json['id'],
      productName: json['productName'],
      modelNumber: json['modelNumber'],
      price: json['price'],
      manufactureDate: json['manufactureDate'],
      manufactureAddress: json['manufactureAddress'],
        productType: json['productType'],
    );
  }

  dynamic get(String propertyName) {
    var _mapRep = toJson();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}
