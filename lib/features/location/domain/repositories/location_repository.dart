import 'package:app_captusiat/core/error/failure.dart';
import 'package:app_captusiat/features/location/domain/entities/location.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationRepository {
  Future<Either<Failure, bool>> requestPermissionPosition();

  Future<Either<Failure, Location>> getCurrentPosition();

  Stream<Either<Failure, Position>> getLocationUpdates();

  Future<Either<Failure, void>> savePosition(
      int turnoId, double latitud, double longitud);
}
