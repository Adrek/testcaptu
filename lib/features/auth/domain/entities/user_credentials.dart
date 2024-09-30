import 'dart:convert';

class UserCredentials {
  final int id;
  final String username;
  final String token;
  final String refreshToken;

  UserCredentials({
    required this.id,
    required this.username,
    required this.token,
    required this.refreshToken,
  });

  factory UserCredentials.fromJson(Map<String, dynamic> json) =>
      UserCredentials(
        id: json["id"],
        username: json["username"],
        token: json["token"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "token": token,
        "refreshToken": refreshToken,
      };

  String toJsonString() {
    return json.encode(toJson());
  }

  static UserCredentials fromJsonString(String jsonString) {
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    return UserCredentials.fromJson(jsonMap);
  }
}
