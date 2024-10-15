class TurnoApiModel {
  final DateTime? horaSalida;
  final int turno;
  final DateTime horaIngreso;

  TurnoApiModel({
    required this.horaSalida,
    required this.turno,
    required this.horaIngreso,
  });

  factory TurnoApiModel.fromJson(Map<String, dynamic> json) => TurnoApiModel(
        horaSalida: json["horaSalida"] != null
            ? DateTime.parse(json["horaSalida"])
            : null,
        turno: json["turno"],
        horaIngreso: DateTime.parse(json["horaIngreso"]),
      );

  Map<String, dynamic> toJson() => {
        "horaSalida": horaSalida?.toIso8601String(),
        "turno": turno,
        "horaIngreso": horaIngreso.toIso8601String(),
      };
}
