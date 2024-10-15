import 'package:app_captusiat/core/services/network_service.dart';
import 'package:app_captusiat/features/turnos/data/mappers/turno_mapper.dart';
import 'package:app_captusiat/features/turnos/data/models/turno_supabase_model.dart';
import 'package:app_captusiat/features/turnos/domain/entities/turno.dart';
import 'package:get/get.dart';

class TurnoRemoteDataSourceSupabase {
  final NetworkService networkService;

  TurnoRemoteDataSourceSupabase(this.networkService);

  Future<Turno?> getTurnoAbiertoHoy(int userId) async {
    try {
      final response = await networkService.get(
        '/turnos',
        queryParameters: {
          "select": "*",
          "user_id": "eq.$userId",
          "order": "id.desc",
        },
      );

      final turnos = List<TurnoSupabaseModel>.from(
          response.data.map((e) => TurnoSupabaseModel.fromJson(e)));

      final today = DateTime.now();

      // Obtiene el último turno registrado en el día
      final lastTurno = turnos.firstWhereOrNull((e) {
        DateTime createdAtLocal = e.createdAt.toLocal();
        return createdAtLocal.year == today.year &&
            createdAtLocal.month == today.month &&
            createdAtLocal.day == today.day;
      });

      // Si no hay ningún turno registrado, envía null para crear uno nuevo.
      if (lastTurno == null) return null;

      // Si encontró turno, pero endTime está completo es porque ya cerró ese turno
      // así que envía null para crear uno nuevo.
      if (lastTurno.endTime != null) return null;

      // Sino, devuelve el turno, lo pone en memoria para cerrarlo más tarde
      return TurnoMapper.fromTurnoSupabaseModel(lastTurno);
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> iniciarTurno(int userId) async {
    try {
      await networkService.post(
        '/turnos',
        data: {
          "user_id": userId,
        },
      );
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> finalizarTurno(int turnoId) async {
    final now = DateTime.now().toUtc().toIso8601String();

    try {
      await networkService.patch(
        '/turnos',
        queryParameters: {
          "id": "eq.$turnoId",
        },
        data: {
          "end_time": now,
        },
      );
    } catch (e) {
      throw Exception();
    }
  }
}
