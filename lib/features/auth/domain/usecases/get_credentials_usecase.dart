import 'package:app_captusiat/core/error/failure.dart';
import 'package:app_captusiat/core/utils/use_case.dart';
import 'package:app_captusiat/features/auth/domain/entities/user_credentials.dart';
import 'package:app_captusiat/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetCredentialsUseCase implements UseCase<UserCredentials?, NoParams> {
  final AuthRepository repository;

  GetCredentialsUseCase(this.repository);

  @override
  Future<Either<Failure, UserCredentials?>> call(NoParams params) {
    return repository.getCredentials();
  }
}
