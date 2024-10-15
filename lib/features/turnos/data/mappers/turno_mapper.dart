import 'package:app_captusiat/features/turnos/data/models/turno_api_model.dart';
import 'package:app_captusiat/features/turnos/data/models/turno_supabase_model.dart';
import 'package:app_captusiat/features/turnos/domain/entities/turno.dart';

class TurnoMapper {
  static Turno fromTurnoSupabaseModel(TurnoSupabaseModel model) {
    return Turno(
      id: model.id,
      userId: model.userId,
      startTime: model.startTime,
      endTime: model.endTime,
      createdAt: model.createdAt,
    );
  }

  static Turno fromTurnoApiModel(TurnoApiModel model) {
    return Turno(
      id: model.turno,
      userId: 0, // TODO: Solicitar userId
      startTime: model.horaIngreso,
      endTime: model.horaSalida,
      createdAt: DateTime.now(), // TODO: Nunca debería ser null
    );
  }
}
