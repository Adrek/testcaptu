import 'package:app_captusiat/core/error/failure.dart';
import 'package:app_captusiat/features/location/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationUpdatesUseCase {
  final LocationRepository repository;

  GetLocationUpdatesUseCase(this.repository);

  Stream<Either<Failure, Position>> call() {
    return repository.getLocationUpdates();
  }
}
