import 'package:app_captusiat/app_bindings.dart';
import 'package:app_captusiat/core/routes/app_pages.dart';
import 'package:app_captusiat/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme().getTheme(context),
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      initialRoute: AppRoutes.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
