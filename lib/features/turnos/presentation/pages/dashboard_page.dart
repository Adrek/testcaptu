import 'package:animate_do/animate_do.dart';
import 'package:app_captusiat/core/theme/app_theme.dart';
import 'package:app_captusiat/core/utils/utils.dart';
import 'package:app_captusiat/core/widgets/widgets.dart';
import 'package:app_captusiat/features/auth/presentation/controllers/auth_controller.dart';
import 'package:app_captusiat/features/location/domain/usecases/get_location_updates_usecase.dart';
import 'package:app_captusiat/features/location/domain/usecases/request_location_permission_usecase.dart';
import 'package:app_captusiat/features/location/domain/usecases/send_location_usecase.dart';
import 'package:app_captusiat/features/turnos/domain/usecases/buscar_turno_activo_usecase.dart';
import 'package:app_captusiat/features/turnos/domain/usecases/finalizar_turno_usecase.dart';
import 'package:app_captusiat/features/turnos/domain/usecases/iniciar_turno_usecase.dart';
import 'package:app_captusiat/features/turnos/presentation/controllers/turno_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
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

  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const inDuration = Duration(milliseconds: 400);

    return Scaffold(
      backgroundColor: Colorize().defaultSurface,
      body: _Body(
        controller: controller,
        height: height,
        width: width,
        inDuration: inDuration,
      ),
      bottomNavigationBar: FadeInUp(
        delay: const Duration(milliseconds: 450),
        duration: inDuration,
        child: _NavigationBar(controller),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final TurnoPageController controller;

  const _Body({
    required this.controller,
    required this.height,
    required this.width,
    required this.inDuration,
  });

  final double height;
  final double width;
  final Duration inDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(width: width, inDuration: inDuration),
        Expanded(
          child: Container(
            // color: Colors.red,
            margin: const EdgeInsets.only(top: 60.0),
            padding: const EdgeInsets.symmetric(
              horizontal: Content.padding,
              vertical: Content.padding,
            ),
            child: Column(
              children: [
                Expanded(
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: FadeInLeft(
                            delay: const Duration(milliseconds: 100),
                            duration: inDuration,
                            child: _KpiCard(
                              title: 'Capturas',
                              subTitle: 'Realizadas del día',
                              numberValue: 0,
                              footer: 'placas vehiculares',
                              prefixIcon: SvgPicture.asset(
                                'assets/icons/line_chart.svg',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: Content.padding * .7),
                        Expanded(
                          child: FadeInRight(
                            delay: const Duration(milliseconds: 300),
                            duration: inDuration,
                            child: const _KpiCard(
                              title: 'Plaqueos',
                              subTitle: 'Totales registrados',
                              numberValue: 0,
                              footer: 'actualizado',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Content.padding * .70),
                Obx(
                  () {
                    if (controller.validarTurnoError.value != null) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: Text(
                                  controller.validarTurnoError.value ?? '')),
                          const SizedBox(width: 10),
                          RoundedButton(
                            label: 'Reintentar',
                            onTap: () => controller.validarTurnoVigente(),
                          ),
                        ],
                      );
                    } else {
                      return FadeIn(
                        delay: const Duration(milliseconds: 800),
                        child: Obx(
                          () => FadeIn(
                            key: ValueKey(
                                'vKBtn${controller.modoIniciarTurno.value}'),
                            child: AnimatedToggle(
                              controller: controller.toggleController,
                              text: controller.modoIniciarTurno.value
                                  ? 'Iniciar el viaje'
                                  : 'Finalizar turno',
                              arrowsColor: controller.modoIniciarTurno.value
                                  ? Colors.white
                                  : Colorize().accentFill,
                              foregroundColor: controller.modoIniciarTurno.value
                                  ? Colorize().accentFill
                                  : Colors.white,
                              backgroundColor: controller.modoIniciarTurno.value
                                  ? Colors.white
                                  : Colorize().accentFill,
                              textColor: controller.modoIniciarTurno.value
                                  ? Colorize().accentFill
                                  : Colors.white,
                              direction: controller.modoIniciarTurno.value
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              action: (_) async {
                                controller.toggleController?.loading();
                                await Future.delayed(
                                  const Duration(milliseconds: 1500),
                                );
                                if (controller.modoIniciarTurno.value) {
                                  controller.iniciarTurno();
                                } else {
                                  controller.finalizarTurno();
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),

                /* const SizedBox(
                  height: Spacing.sm * .3,
                ),
                Obx(
                  () => controller.isIniciarButtonVisible.value
                      ? SwitcherButton(
                          onTap: () {
                            controller.iniciarTurno();
                          },
                        )
                      : const SizedBox(),
                ),
                Obx(
                  () => controller.isFinalizarButtonVisible.value
                      ? SwitcherButton(
                          esUnido: true,
                          onTap: () {
                            controller.finalizarTurno();
                          },
                        )
                      : const SizedBox(),
                ), */
                const SizedBox(height: Content.padding * .70),
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  duration: inDuration,
                  child: const _CardConsultaPlacas(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.width,
    required this.inDuration,
  });

  final double width;
  final Duration inDuration;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final spaceHeight = height * .05;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppBarBase(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: spaceHeight),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Buen día,\nAlec González',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'LUNES 12 DE JUNIO',
                            style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      )),
                      const BrandName(
                        textSize: 18.0,
                      ),
                    ],
                  ),
                  SizedBox(height: spaceHeight),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: -50,
          bottom: -70,
          child: SizedBox(
            width: width * .75,
            child: FadeInRight(
              delay: const Duration(milliseconds: 100),
              duration: inDuration,
              child: Image.asset('assets/images/car_home.png'),
            ),
          ),
        )
      ],
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final int numberValue;
  final String footer;
  final Widget? prefixIcon;

  const _KpiCard(
      {this.title = '',
      this.subTitle = '',
      this.numberValue = 0,
      this.footer = '',
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    final cardRadius = BorderRadius.circular(16.0);

    return Container(
      decoration: BoxDecoration(
        borderRadius: cardRadius,
        color: Colors.white,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: cardRadius,
          highlightColor: Colors.black.withOpacity(.035),
          splashColor: Colors.black.withOpacity(.045),
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 15.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: Colorize().bodyText,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            subTitle,
                            style: TextStyle(
                              color: Colorize().bodyText,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child:
                            SvgPicture.asset('assets/icons/arrow_right.svg')),
                    const SizedBox(width: 5.0),
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      if (prefixIcon != null) Flexible(child: prefixIcon!),
                      if (prefixIcon != null) const SizedBox(width: 6.0),
                      Text(
                        '$numberValue',
                        style: TextStyle(
                          color: Colorize().bodyText,
                          fontWeight: FontWeight.w500,
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  footer,
                  style: TextStyle(
                      color: Colorize().bodyText,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardConsultaPlacas extends StatelessWidget {
  const _CardConsultaPlacas();

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15.0);

    final circleSize = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                  child: Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.indigo,
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/map_placeholder.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Stack(
                      children: [
                        Positioned(
                          top: -900,
                          bottom: -900,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: circleSize,
                              height: circleSize,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Empezar la\nconsulta de placas',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Flexible(
                                    child: RoundedButton(label: 'INGRESAR'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFB9B9B9),
                          boxShadow: [
                            BoxShadow(
                              color: ColorsUtils.darken(const Color(0xFFB9B9B9))
                                  .withOpacity(.5),
                              offset: const Offset(0, 6),
                              blurRadius: 10.0,
                            )
                          ]),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: SvgPicture.asset(
                            'assets/icons/gps.svg',
                            width: 18,
                          )),
                      // child: Icon(Icons),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  final TurnoPageController controller;

  const _NavigationBar(this.controller);

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: Content.padding),
      decoration: BoxDecoration(
        color: Colorize().primaryFill,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _OptionItem(
            label: 'Inicio',
            iconName: 'home',
          ),
          /* _OptionItem(
            label: 'Digitar',
            iconName: 'search_outlilne',
          ), */
          _OptionItem(
            label: 'Cerrar sesión',
            iconName: 'settings_outline',
            onTap: () {
              controller.logout();
            },
          ),
        ],
      ),
    );

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 40.0,
        horizontal: Content.padding - 5,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(500.0),
        child: Container(
          height: 55.0,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colorize().primaryFill,
          ),
          child: Row(
            children: [
              Expanded(
                child: _NavigationItem(
                  iconPath: 'assets/icons/car.svg',
                  iconSize: 18.0,
                  onTap: () {},
                ),
              ),
              Expanded(
                child: _NavigationItem(
                  iconPath: 'assets/icons/keyboard.svg',
                  iconSize: 18.0,
                  onTap: () {
                    // Get.toNamed(AppRoutes.PLAQUEOS);
                  },
                ),
              ),
              Expanded(
                child: _NavigationItem(
                  iconPath: 'assets/icons/chart.svg',
                  onTap: () {
                    // Get.toNamed(AppRoutes.REPORTES);
                  },
                ),
              ),
              Expanded(
                child: _NavigationItem(
                  iconPath: 'assets/icons/settings.svg',
                  onTap: () {
                    // Get.toNamed(AppRoutes.SETTINGS);
                    controller.logout();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  final String label;
  final String iconName;
  final VoidCallback? onTap;

  const _OptionItem({
    required this.label,
    required this.iconName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          splashColor: ColorsUtils.lighten(Colorize().primaryFill, 0.035),
          highlightColor: ColorsUtils.lighten(Colorize().primaryFill, 0.05),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox.square(
                  dimension: Spacing.xl3 - 4,
                  child: SvgPicture.asset(
                    'assets/icons/$iconName.svg',
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(.75),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: Spacing.md,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(.75),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  final String iconPath;
  final double iconSize;
  final VoidCallback? onTap;

  const _NavigationItem({
    required this.iconPath,
    this.iconSize = 16.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: double.infinity,
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: iconSize,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
