import 'package:app_captusiat/core/error/failure.dart';
import 'package:app_captusiat/core/utils/use_case.dart';
import 'package:app_captusiat/features/turnos/domain/entities/turno.dart';
import 'package:app_captusiat/features/turnos/domain/repositories/turno_repository.dart';
import 'package:dartz/dartz.dart';

class BuscarTurnoActivoUseCase implements UseCase<Turno?, int> {
  final TurnoRepository turnoRepository;

  BuscarTurnoActivoUseCase(this.turnoRepository);

  @override
  Future<Either<Failure, Turno?>> call(int userId) async {
    return turnoRepository.buscarTurnoActivo(userId);
  }
}
