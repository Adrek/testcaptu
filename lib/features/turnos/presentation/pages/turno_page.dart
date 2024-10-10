import 'package:app_captusiat/core/theme/app_theme.dart';
import 'package:app_captusiat/core/widgets/widgets.dart';
import 'package:app_captusiat/features/alerting/alerting_page.dart';
import 'package:app_captusiat/features/auth/presentation/controllers/auth_controller.dart';
import 'package:app_captusiat/features/location/domain/usecases/get_location_updates_usecase.dart';
import 'package:app_captusiat/features/location/domain/usecases/request_location_permission_usecase.dart';
import 'package:app_captusiat/features/location/domain/usecases/send_location_usecase.dart';
import 'package:app_captusiat/features/turnos/domain/entities/turno.dart';
import 'package:app_captusiat/features/turnos/domain/usecases/buscar_turno_activo_usecase.dart';
import 'package:app_captusiat/features/turnos/domain/usecases/finalizar_turno_usecase.dart';
import 'package:app_captusiat/features/turnos/domain/usecases/iniciar_turno_usecase.dart';
import 'package:app_captusiat/features/turnos/presentation/controllers/turno_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TurnoPage extends StatelessWidget {
  /* final locationController = Get.put(LocationController(
    requestPermissionUseCase: Get.find<RequestLocationPermissionUseCase>(),
    getLocationUseCase: Get.find<GetLocationUseCase>(),
    getLocationUpdatesUseCase: Get.find<GetLocationUpdatesUseCase>(),
  )); */

  final controller = Get.put(TurnoPageController(
    userCredentials: Get.find<AuthController>().userCredentials!,
    buscarTurnoActivoUseCase: Get.find<BuscarTurnoActivoUseCase>(),
    iniciarTurnoUseCase: Get.find<IniciarTurnoUseCase>(),
    finalizarTurnoUseCase: Get.find<FinalizarTurnoUseCase>(),
    requestLocationPermissionUseCase:
        Get.find<RequestLocationPermissionUseCase>(),
    getLocationUpdatesUseCase: Get.find<GetLocationUpdatesUseCase>(),
    sendLocationUseCase: Get.find<SendLocationUseCase>(),
  ));

  TurnoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colorize().primaryFill,
          body: _Body(
            controller: controller,
          ),
        ),
        Obx(
          () => controller.isLoading.value
              ? const LoadingLayer()
              : const SizedBox(),
        )
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.controller,
  });

  final TurnoPageController controller;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Obx(() => controller.isFinalizarButtonVisible.value
            ? AlertingPage()
            : const SizedBox()),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.07,
              vertical: width * 0.07,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BrandName(
                            textSize: 20.0,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Usuario:  ${controller.userCredentials.username}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: 14.0,
                            ),
                          )
                        ],
                      ),
                    ),
                    Opacity(
                      opacity: .54,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.logout();
                        },
                        child: const Text('Salir'),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* Obx(() => controller.locationError.value != null
                          ? Container(
                              decoration:
                                  const BoxDecoration(color: Colors.red),
                              child: Text(controller.locationError.value ?? ''),
                            )
                          : const SizedBox()),
                      Obx(() => controller.turnoActivo.value != null
                          ? TurnoInfo(turno: controller.turnoActivo.value!)
                          : const SizedBox()),
                      const SizedBox(height: 10.0), */
                      Obx(
                        () => controller.isIniciarButtonVisible.value
                            ? _LaunchTurnoButton(
                                isStart: true,
                                onTap: () {
                                  controller.iniciarTurno();
                                })
                            : const SizedBox(),
                      ),
                      Obx(
                        () => controller.isFinalizarButtonVisible.value
                            ? _LaunchTurnoButton(
                                isStart: false,
                                onTap: () {
                                  controller.finalizarTurno();
                                })
                            : const SizedBox(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TurnoInfo extends StatelessWidget {
  final Turno turno;

  const TurnoInfo({
    super.key,
    required this.turno,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.greenAccent.withOpacity(.86),
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      child: Text('ID: ${turno.id} -  Inicio: ${turno.startTime.toLocal()}'),
    );
  }
}

class _LaunchTurnoButton extends StatelessWidget {
  final bool isStart;
  final VoidCallback onTap;

  const _LaunchTurnoButton({
    required this.isStart,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          isStart ? Colors.greenAccent : Colors.redAccent,
        ),
      ),
      child: Text(
        isStart ? 'Iniciar turno' : 'Finalizar turno',
        style: TextStyle(
          color: isStart ? Colorize().primaryFill : Colors.white,
        ),
      ),
    );
  }
}
