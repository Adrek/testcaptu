import 'package:app_captusiat/core/services/network_service.dart';
import 'package:app_captusiat/core/utils/utils.dart';

class PosicionesRemoteDataSource {
  final NetworkService _networkService;

  PosicionesRemoteDataSource(this._networkService);

  Future<void> crearPosicion(
      int turnoId, double latitud, double longitud) async {
    try {
      await _networkService.dio.post(
        '/posiciones',
        data: {
          "pbidTurno": turnoId,
          "platitud": latitud,
          "plongitud": longitud
        },
      );
    } catch (e) {
      throw ServerException();
    }
  }
}
