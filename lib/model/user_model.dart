class UserDataModel {
  String? userName;
  String? password;
  String? dob;

  UserDataModel({
    this.userName,
    this.password,
    this.dob,
  });

  UserDataModel.fromMap(Map<String, Object?> first);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['password'] = password;
    data['dob'] = dob;

    return data;
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      userName: json['userName'],
      password: json['password'],
      dob: json['dob'],
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
