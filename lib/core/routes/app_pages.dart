// ignore_for_file: constant_identifier_names

import 'package:app_captusiat/core/widgets/widgets.dart';
import 'package:app_captusiat/features/alerting/alerting_page.dart';
import 'package:app_captusiat/features/auth/presentation/pages/login_page.dart';
import 'package:app_captusiat/features/splash/presentation/pages/splash_page.dart';
import 'package:app_captusiat/features/turnos/presentation/pages/dashboard_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    // SPLASH
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
    ),
    // LOGIN
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginPage(),
    ),
    // HOME
    // GetPage(
    //   name: AppRoutes.HOME,
    //   page: () => HomePage(),
    // ),/*  */
    // TURNO
    GetPage(
      name: AppRoutes.TURNO,
      page: () => DashboardPage(),
    ),

    // ALERTING
    GetPage(
      name: AppRoutes.ALERTING,
      page: () => AlertingPage(),
    ),

    // MISC
    GetPage(
      name: AppRoutes.PRUEBA,
      page: () => const PruebaPage(),
    ),
  ];
}
