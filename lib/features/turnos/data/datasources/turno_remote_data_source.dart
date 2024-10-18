import 'package:app_captusiat/core/services/network_service.dart';
import 'package:app_captusiat/features/turnos/data/mappers/turno_mapper.dart';
import 'package:app_captusiat/features/turnos/data/models/turno_api_model.dart';
import 'package:app_captusiat/features/turnos/domain/entities/turno.dart';

class TurnoRemoteDataSource {
  final NetworkService networkService;

  TurnoRemoteDataSource(this.networkService);

  Future<Turno?> getTurnoAbiertoHoy(int userId) async {
    try {
      final response = await networkService.get('/ListaTurno/$userId');

      final turnos = List<TurnoApiModel>.from(
          response.data.map((e) => TurnoApiModel.fromJson(e)));

      if (turnos.isEmpty) {
        return null;
      } else {
        return TurnoMapper.fromTurnoApiModel(turnos.first);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> iniciarTurno(int userId) async {
    try {
      await networkService.post(
        '/turno',
        data: {
          "psitipo": 1, // TODO: Para qué es?
          "pbiuser_id": userId
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> finalizarTurno(int turnoId) async {
    try {
      await networkService.post('/turno/$turnoId/cerrar');
    } catch (e) {
      throw Exception(e);
    }
  }
}
