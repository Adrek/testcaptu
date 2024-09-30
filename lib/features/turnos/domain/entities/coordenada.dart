class Coordenada {
  final int id;
  final int turnoId;
  final int latitude;
  final int longitude;
  final DateTime createdAt;

  Coordenada({
    required this.id,
    required this.turnoId,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
  });

  factory Coordenada.fromJson(Map<String, dynamic> json) => Coordenada(
        id: json["id"],
        turnoId: json["turno_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "turno_id": turnoId,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt.toIso8601String(),
      };
}
