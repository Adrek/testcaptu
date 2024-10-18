import 'package:app_captusiat/core/error/failure.dart';
import 'package:app_captusiat/features/location/data/datasources/posiciones_remote_data_source.dart';
import 'package:app_captusiat/features/location/domain/entities/location.dart';
import 'package:app_captusiat/features/location/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepositoryImpl implements LocationRepository {
  final PosicionesRemoteDataSource posicionesRemoteDataSourceSupabase;

  LocationRepositoryImpl(this.posicionesRemoteDataSourceSupabase);

  @override
  Future<Either<Failure, bool>> requestPermissionPosition() async {
    /* LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Left(LocationPermissionDeniedFailure());
    }
    return const Right(true); */

    final status = await Geolocator.requestPermission();
    if (status == LocationPermission.always ||
        status == LocationPermission.whileInUse) {
      return const Right(true);
    } else {
      return Left(LocationPermissionFailure());
    }
  }

  @override
  Future<Either<Failure, Location>> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Left(LocationServiceDisabledFailure());
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return Left(LocationPermissionDeniedFailure());
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      return Right(
          Location(latitude: position.latitude, longitude: position.longitude));
    } catch (e) {
      return Left(
          LocationPermissionDeniedFailure()); // Manejo básico de errores
    }
  }

  @override
  Stream<Either<Failure, Position>> getLocationUpdates() async* {
    try {
      // Escucha cambios en la ubicación
      await for (final position in Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      )) {
        debugPrint('llegando posición');
        yield Right(position);
        // Enviar la ubicación al backend en cada actualización
        // TODO: Debería ir sendLocation allí o hacerlo en el controller
        // await sendLocation(position);
      }
    } catch (e) {
      yield Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> savePosition(
      int turnoId, double latitud, double longitud) async {
    try {
      await posicionesRemoteDataSourceSupabase.crearPosicion(
          turnoId, latitud, longitud);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
