import 'package:app_captusiat/core/services/api_rest_service.dart';
import 'package:app_captusiat/core/services/auth_rest_service.dart';
import 'package:app_captusiat/core/services/local_storage_service.dart';
import 'package:app_captusiat/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:app_captusiat/features/auth/data/datasources/auth_remote_data_source_ws.dart';
import 'package:app_captusiat/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_captusiat/features/auth/domain/usecases/get_credentials_usecase.dart';
import 'package:app_captusiat/features/auth/domain/usecases/login_usecase.dart';
import 'package:app_captusiat/features/auth/domain/usecases/logout_usecase.dart';
import 'package:app_captusiat/features/auth/presentation/controllers/auth_controller.dart';
import 'package:app_captusiat/features/location/data/datasources/posiciones_remote_data_source.dart';
import 'package:app_captusiat/features/location/data/repositories/location_repository_impl.dart';
import 'package:app_captusiat/features/location/domain/usecases/get_location_updates_usecase.dart';
import 'package:app_captusiat/features/location/domain/usecases/get_location_usecase.dart';
import 'package:app_captusiat/features/location/domain/usecases/request_location_permission_usecase.dart';
import 'package:app_captusiat/features/location/domain/usecases/send_location_usecase.dart';
import 'package:app_captusiat/features/turnos/data/datasources/turno_remote_data_source.dart';
import 'package:app_captusiat/features/turnos/data/repositories/turno_repository_impl.dart';
import 'package:app_captusiat/features/turnos/domain/usecases/buscar_turno_activo_usecase.dart';
import 'package:app_captusiat/features/turnos/domain/usecases/finalizar_turno_usecase.dart';
import 'package:app_captusiat/features/turnos/domain/usecases/iniciar_turno_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Core services

    final dioAuth = Dio(BaseOptions());
    final dioWS = Dio(BaseOptions());
    Get.put(LocalStorageService());
    // final networkService = Get.put(SupabaseApiService(dio));
    final networkServiceAuth = Get.put(AuthRestService(dioAuth));
    final networkServiceWS = Get.put(ApiRestService(dioWS));

    // Auth dependencies
    Get.put(AuthLocalDataSource(Get.find<LocalStorageService>()));
    Get.put(AuthRemoteDataSourceWS(networkServiceAuth));

    final authRepository = Get.put(AuthRepositoryImpl(
      localDataSource: Get.find<AuthLocalDataSource>(),
      remoteDataSource: Get.find<AuthRemoteDataSourceWS>(),
    ));

    Get.put(LoginUseCase(authRepository));
    Get.put(GetCredentialsUseCase(authRepository));
    Get.put(LogoutUseCase(authRepository));

    // Location dependencies
    Get.put(PosicionesRemoteDataSource(networkServiceWS));

    final locationRepository = Get.put(LocationRepositoryImpl(
      Get.find<PosicionesRemoteDataSource>(),
    ));
    Get.put(RequestLocationPermissionUseCase(locationRepository));
    Get.put(GetLocationUseCase(locationRepository));
    Get.put(GetLocationUpdatesUseCase(locationRepository));
    Get.put(SendLocationUseCase(locationRepository));

    // Turno dependencies
    Get.put(TurnoRemoteDataSource(networkServiceWS));

    final turnoRepository = Get.put(TurnoRepositoryImpl(
      Get.find<TurnoRemoteDataSource>(),
    ));
    Get.put(BuscarTurnoActivoUseCase(turnoRepository));
    Get.put(IniciarTurnoUseCase(turnoRepository));
    Get.put(FinalizarTurnoUseCase(turnoRepository));

    // Controllers
    Get.put(AuthController(
      loginUseCase: Get.find<LoginUseCase>(),
      getCredentialsUseCase: Get.find<GetCredentialsUseCase>(),
      logoutUseCase: Get.find<LogoutUseCase>(),
    ));
  }
}
