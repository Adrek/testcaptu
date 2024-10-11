import 'package:app_captusiat/core/services/api_supabase_service.dart';
import 'package:app_captusiat/core/services/local_storage_service.dart';
import 'package:app_captusiat/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:app_captusiat/features/auth/data/datasources/auth_remote_data_source_supabase.dart';
import 'package:app_captusiat/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_captusiat/features/auth/domain/usecases/get_credentials_usecase.dart';
import 'package:app_captusiat/features/auth/domain/usecases/login_usecase.dart';
import 'package:app_captusiat/features/auth/domain/usecases/logout_usecase.dart';
import 'package:app_captusiat/features/auth/presentation/controllers/auth_controller.dart';
import 'package:app_captusiat/features/location/data/datasources/posiciones_remote_data_source_supabase.dart';
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
    final dio = Get.put(Dio(BaseOptions()));
    Get.put(LocalStorageService());
    final networkService = Get.put(SupabaseApiService(dio));
    // final networkService = Get.put(ApiRestService(dio));

    // Auth dependencies
    Get.put(AuthLocalDataSource(Get.find<LocalStorageService>()));
    Get.put(AuthRemoteDataSourceSupabase(networkService));

    final authRepository = Get.put(AuthRepositoryImpl(
      localDataSource: Get.find<AuthLocalDataSource>(),
      remoteDataSource: Get.find<AuthRemoteDataSourceSupabase>(),
    ));

    Get.put(LoginUseCase(authRepository));
    Get.put(GetCredentialsUseCase(authRepository));
    Get.put(LogoutUseCase(authRepository));

    // Location dependencies
    Get.put(PosicionesRemoteDataSourceSupabase(networkService));

    final locationRepository = Get.put(LocationRepositoryImpl(
      Get.find<PosicionesRemoteDataSourceSupabase>(),
    ));
    Get.put(RequestLocationPermissionUseCase(locationRepository));
    Get.put(GetLocationUseCase(locationRepository));
    Get.put(GetLocationUpdatesUseCase(locationRepository));
    Get.put(SendLocationUseCase(locationRepository));

    // Turno dependencies
    Get.put(TurnoRemoteDataSource(networkService));

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

    /*
    // Location dependencies
    Get.put(LocationRemoteDataSource());
    Get.put(LocationRepositoryImpl(Get.find<LocationRemoteDataSource>()));
    Get.put(GetLocationUseCase(Get.find<LocationRepositoryImpl>()));
    Get.put(RequestLocationPermissionUseCase());

    // Controllers
    Get.put(AuthController(Get.find<LoginUseCase>()));
    Get.put(LocationController(
      getLocationUseCase: Get.find<GetLocationUseCase>(),
      requestLocationPermissionUseCase: Get.find<RequestLocationPermissionUseCase>(),
      dio: Get.find<NetworkService>().dio,
    )); */
  }
}
