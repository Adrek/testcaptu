import 'package:app_captusiat/core/error/failure.dart';
import 'package:app_captusiat/core/utils/use_case.dart';
import 'package:app_captusiat/features/turnos/domain/repositories/turno_repository.dart';
import 'package:dartz/dartz.dart';

class IniciarTurnoUseCase implements UseCase<void, int> {
  final TurnoRepository turnoRepository;

  IniciarTurnoUseCase(this.turnoRepository);

  @override
  Future<Either<Failure, void>> call(int userId) async {
    return turnoRepository.iniciarTurno(userId);
  }
}
