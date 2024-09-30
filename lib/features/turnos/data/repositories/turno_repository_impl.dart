import 'package:app_captusiat/core/error/failure.dart';
import 'package:app_captusiat/features/turnos/data/datasources/turno_remote_data_source.dart';
import 'package:app_captusiat/features/turnos/domain/entities/turno.dart';
import 'package:app_captusiat/features/turnos/domain/repositories/turno_repository.dart';
import 'package:dartz/dartz.dart';

class TurnoRepositoryImpl implements TurnoRepository {
  final TurnoRemoteDataSource turnoRemoteDataSource;

  TurnoRepositoryImpl(this.turnoRemoteDataSource);

  @override
  Future<Either<Failure, Turno?>> buscarTurnoActivo(int userId) async {
    try {
      final turno = await turnoRemoteDataSource.getTurnoAbiertoHoy(userId);
      return Right(turno);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> iniciarTurno(int userId) async {
    try {
      await turnoRemoteDataSource.iniciarTurno(userId);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> finalizarTurno(int turnoId) async {
    try {
      await turnoRemoteDataSource.finalizarTurno(turnoId);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
