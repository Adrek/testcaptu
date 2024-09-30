import 'package:app_captusiat/core/error/failure.dart';
import 'package:app_captusiat/core/utils/use_case.dart';
import 'package:app_captusiat/features/location/domain/entities/location.dart';
import 'package:app_captusiat/features/location/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';

class GetLocationUseCase implements UseCase<Location, NoParams> {
  final LocationRepository repository;

  GetLocationUseCase(this.repository);

  @override
  Future<Either<Failure, Location>> call(NoParams noParams) {
    return repository.getCurrentPosition();
  }
}
