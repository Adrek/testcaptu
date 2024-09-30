import 'package:app_captusiat/core/error/failure.dart';
import 'package:app_captusiat/features/auth/domain/entities/user_credentials.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredentials>> login(
    String username,
    String password,
  );

  Future<Either<Failure, UserCredentials?>> getCredentials();

  Future<Either<Failure, void>> logout();
}
