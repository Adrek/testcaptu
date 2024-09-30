import 'package:app_captusiat/core/error/failure.dart';
import 'package:app_captusiat/core/utils/use_case.dart';
import 'package:app_captusiat/features/location/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';

class RequestLocationPermissionUseCase implements UseCase<bool, NoParams> {
  final LocationRepository repository;

  RequestLocationPermissionUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams noParams) {
    return repository.requestPermissionPosition();
  }
}
