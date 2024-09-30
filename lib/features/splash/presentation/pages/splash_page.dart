import 'package:app_captusiat/core/theme/app_theme.dart';
import 'package:app_captusiat/core/widgets/widgets.dart';
import 'package:app_captusiat/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  final authController = Get.find<AuthController>();

  SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => authController.handleSession(),
    );

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colorize().primaryFill,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Content.padding * .3),
            width: double.infinity,
            color: Colorize().primaryFill,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BrandName(),
                SizedBox(height: 20.0),
                BrandSlogan(),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 10.0,
              color: Colorize().accentFill,
            ),
          ),
          const VersionLateralBar(),
        ],
      ),
    );
  }
}
