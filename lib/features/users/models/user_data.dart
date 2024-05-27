import "dart:convert";

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    this.name,
    this.email,
    this.gender,
  });

  UserData.fromJson(dynamic json) {
    name = json["name"];
    email = json["email"];
    gender = json["gender"];
  }

  String? name;
  String? email;
  String? gender;

  UserData copyWith({
    String? name,
    String? email,
    String? gender,
  }) =>
      UserData(
        name: name ?? this.name,
        email: email ?? this.email,
        gender: gender ?? this.gender,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["name"] = name;
    map["email"] = email;
    map["gender"] = gender;
    return map;
  }
}
