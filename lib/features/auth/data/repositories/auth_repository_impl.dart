import 'package:app_captusiat/core/error/failure.dart';
import 'package:app_captusiat/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:app_captusiat/features/auth/data/datasources/auth_remote_data_source_supabase.dart';
import 'package:app_captusiat/features/auth/domain/entities/user_credentials.dart';
import 'package:app_captusiat/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSourceSupabase remoteDataSource;

  AuthRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, UserCredentials>> login(
      String username, String password) async {
    try {
      final credentials = await remoteDataSource.login(username, password);

      if (credentials == null) return Left(LoginFailure());

      await localDataSource.saveUserCredentials(credentials);

      return Right(credentials);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredentials?>> getCredentials() async {
    try {
      final credentials = await localDataSource.getUserCredentials();

      return Right(credentials);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearUserCredentials();
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
