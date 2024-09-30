import 'package:app_captusiat/core/error/failure.dart';
import 'package:app_captusiat/core/utils/use_case.dart';
import 'package:app_captusiat/features/location/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';

class SendLocationUseCase implements UseCase<void, SendLocationUseCaseParams> {
  final LocationRepository repository;

  SendLocationUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SendLocationUseCaseParams params) {
    return repository.savePosition(
        params.turnoId, params.latitud, params.longitud);
  }
}

class SendLocationUseCaseParams {
  final int turnoId;
  final double latitud;
  final double longitud;

  SendLocationUseCaseParams(
      {required this.turnoId, required this.latitud, required this.longitud});
}
