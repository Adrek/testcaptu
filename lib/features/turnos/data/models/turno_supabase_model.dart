class TurnoSupabaseModel {
  final int id;
  final int userId;
  final DateTime startTime;
  final DateTime? endTime;
  final DateTime createdAt;

  TurnoSupabaseModel({
    required this.id,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
  });

  factory TurnoSupabaseModel.fromJson(Map<String, dynamic> json) =>
      TurnoSupabaseModel(
        id: json["id"],
        userId: json["user_id"],
        startTime: DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] != null ? DateTime.parse(json["end_time"]) : null,
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime,
        "created_at": createdAt.toIso8601String(),
      };
}
