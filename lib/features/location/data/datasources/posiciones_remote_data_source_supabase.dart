import 'package:app_captusiat/core/services/network_service.dart';
import 'package:app_captusiat/core/utils/utils.dart';

class PosicionesRemoteDataSourceSupabase {
  final NetworkService _networkService;

  PosicionesRemoteDataSourceSupabase(this._networkService);

  Future<void> crearPosicion(
      int turnoId, double latitud, double longitud) async {
    try {
      await _networkService.dio.post('/posiciones', data: {
        "turno_id": turnoId,
        "latitud": latitud,
        "longitud": longitud
      });
    } catch (e) {
      throw ServerException();
    }
  }
}
