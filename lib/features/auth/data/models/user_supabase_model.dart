class UserSupabaseModel {
  final int id;
  final String username;
  final String password;
  final DateTime createdAt;

  UserSupabaseModel({
    required this.id,
    required this.username,
    required this.password,
    required this.createdAt,
  });

  factory UserSupabaseModel.fromJson(Map<String, dynamic> json) =>
      UserSupabaseModel(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "created_at": createdAt.toIso8601String(),
      };
}
