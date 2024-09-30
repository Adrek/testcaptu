import 'package:app_captusiat/core/error/failure.dart';
import 'package:app_captusiat/features/turnos/domain/entities/turno.dart';
import 'package:dartz/dartz.dart';

abstract class TurnoRepository {
  Future<Either<Failure, Turno?>> buscarTurnoActivo(int userId);

  Future<Either<Failure, void>> iniciarTurno(int userId);

  Future<Either<Failure, void>> finalizarTurno(int turnoId);
}
