import 'package:animate_do/animate_do.dart';
import 'package:app_captusiat/core/theme/app_theme.dart';
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
            margin: const EdgeInsets.only(top: 80.0),
            padding: EdgeInsets.symmetric(
              horizontal: Content.padding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
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
                    SizedBox(width: Content.padding * .7),
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
                const SizedBox(
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
                ),
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
                          Text(
                            'Buen día,\nAlec González',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 10.0),
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
                      BrandName(
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
          onTap: () {
            print('asd');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 15.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                Row(
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
                                    child: FilledButton(
                                      style: ButtonStyle(
                                        padding: WidgetStatePropertyAll(
                                          EdgeInsets.symmetric(
                                            vertical: 0.0,
                                            horizontal: 20.0,
                                          ),
                                        ),
                                        backgroundColor: WidgetStatePropertyAll(
                                          Colorize().accentFill,
                                        ),
                                      ),
                                      onPressed: () {
                                        // Get.toNamed(AppRoutes.PLAQUEOS);
                                      },
                                      child: const Text('INGRESAR'),
                                    ),
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
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colorize().primaryFill,
                          boxShadow: [
                            BoxShadow(
                              color: Colorize().primaryFill.withOpacity(.5),
                              offset: const Offset(0, 6),
                              blurRadius: 10.0,
                            )
                          ]),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: SvgPicture.asset('assets/icons/gps.svg')),
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
      margin: EdgeInsets.symmetric(
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
