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
}
