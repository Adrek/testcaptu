import 'dart:async';

import 'package:action_slider/action_slider.dart';
import 'package:app_captusiat/core/utils/use_case.dart';
import 'package:app_captusiat/features/auth/domain/entities/user_credentials.dart';
import 'package:app_captusiat/features/auth/presentation/controllers/auth_controller.dart';
import 'package:app_captusiat/features/location/domain/usecases/get_location_updates_usecase.dart';
import 'package:app_captusiat/features/location/domain/usecases/request_location_permission_usecase.dart';
import 'package:app_captusiat/features/location/domain/usecases/send_location_usecase.dart';
import 'package:app_captusiat/features/turnos/domain/entities/turno.dart';
import 'package:app_captusiat/features/turnos/domain/usecases/buscar_turno_activo_usecase.dart';
import 'package:app_captusiat/features/turnos/domain/usecases/finalizar_turno_usecase.dart';
import 'package:app_captusiat/features/turnos/domain/usecases/iniciar_turno_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TurnoPageController extends GetxController {
  late TurnoPageController _self;

  final UserCredentials userCredentials;
  final BuscarTurnoActivoUseCase buscarTurnoActivoUseCase;
  final IniciarTurnoUseCase iniciarTurnoUseCase;
  final FinalizarTurnoUseCase finalizarTurnoUseCase;

  final RequestLocationPermissionUseCase requestLocationPermissionUseCase;
  final GetLocationUpdatesUseCase getLocationUpdatesUseCase;
  final SendLocationUseCase sendLocationUseCase;

  TurnoPageController({
    required this.userCredentials,
    required this.buscarTurnoActivoUseCase,
    required this.iniciarTurnoUseCase,
    required this.finalizarTurnoUseCase,
    required this.requestLocationPermissionUseCase,
    required this.getLocationUpdatesUseCase,
    required this.sendLocationUseCase,
  });

  final locationError = RxnString();

  final isLoading = false.obs;

  /* final isIniciarButtonVisible = false.obs;
  final isFinalizarButtonVisible = false.obs; */

  final turnoActivo = Rxn<Turno>(null);

  final modoIniciarTurno = false.obs;

  ActionSliderController? toggleController;

  @override
  void onInit() {
    super.onInit();
    _self = this;
    toggleController = ActionSliderController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _requestLocationPermission();
      toggleController?.loading();
    });
  }

  @override
  void onClose() {
    toggleController?.dispose();
    super.onClose();
  }

  final validarTurnoError = RxnString();
  Future<void> validarTurnoVigente() async {
    if (_self.isClosed) return;
    if (isLoading.value) return;

    isLoading(true);

    toggleController?.loading();

    validarTurnoError.value = null;

    final validarResult =
        await buscarTurnoActivoUseCase.call(userCredentials.id);

    toggleController?.reset();

    validarResult.fold(
      (failure) {
        const msg = 'Fallo al buscar turno activo';
        debugPrint(msg);
        validarTurnoError.value = msg;
      },
      (existeTurnoActivo) {
        if (existeTurnoActivo != null) {
          turnoActivo.value = existeTurnoActivo;
          /* isFinalizarButtonVisible(true);
          isIniciarButtonVisible(false); */

          modoIniciarTurno.value = false;

          // TODO: DESCOMENTAR
          startLocationListener();
        } else {
          turnoActivo.value = null;

          modoIniciarTurno.value = true;
          /* isIniciarButtonVisible(true);
          isFinalizarButtonVisible(false); */

          // Detenemos la escucha de la posición
          // TODO: DESCOMENTAR
          stopLocationListener();
        }
      },
    );

    isLoading(false);
  }

  Future<void> iniciarTurno() async {
    if (isLoading.value) return;

    isLoading(true);
    final result = await iniciarTurnoUseCase.call(userCredentials.id);
    result.fold(
      (failure) => {debugPrint('Fallo al inicializar')},
      (success) => {debugPrint('Inicializado!')},
    );
    isLoading(false);

    validarTurnoVigente();
  }

  Future<void> finalizarTurno() async {
    if (turnoActivo.value == null) return;

    if (isLoading.value) return;

    isLoading(true);
    final result = await finalizarTurnoUseCase.call(turnoActivo.value!.id);
    result.fold(
      (failure) => {debugPrint('Fallo al finalizar')},
      (success) => {debugPrint('Finalizado!')},
    );
    isLoading(false);

    validarTurnoVigente();
  }

  Future<void> _requestLocationPermission() async {
    final permissionResult =
        await requestLocationPermissionUseCase.call(NoParams());
    permissionResult.fold((failure) {
      const error = 'Error al solicitar permiso de navegación';
      locationError.value = error;
      debugPrint(error);
    }, (success) {
      locationError.value = null;
      debugPrint('Location permission granted!');
      validarTurnoVigente();
    });
  }

  StreamSubscription? locationSubscription;

  Future<void> startLocationListener() async {
    locationSubscription = getLocationUpdatesUseCase().listen(
      (eitherPositionOrFailure) {
        eitherPositionOrFailure.fold(
          (failure) {
            debugPrint('Error getting location updates');
          },
          (location) {
            debugPrint(
                'Lat: ${location.latitude}, Long: ${location.longitude}');

            if (turnoActivo.value != null) {
              sendPositionToBackend(
                  turnoActivo.value!.id, location.latitude, location.longitude);
            }
          },
        );
      },
    );
  }

  Future<void> stopLocationListener() async {
    locationSubscription?.cancel();
  }

  Future<void> sendPositionToBackend(
    int turnoId,
    double latitud,
    double longitud,
  ) async {
    final result = await sendLocationUseCase.call(
      SendLocationUseCaseParams(
        turnoId: turnoId,
        latitud: latitud,
        longitud: longitud,
      ),
    );
    result.fold(
      (failure) => debugPrint('Fallo al enviar las coordenadas'),
      (success) => debugPrint('Coordenadas enviadas!'),
    );
  }

  Future<void> logout() async {
    Get.find<AuthController>().logout();
  }
}
