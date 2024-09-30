import 'package:app_captusiat/core/theme/app_theme.dart';
import 'package:app_captusiat/core/widgets/widgets.dart';
import 'package:app_captusiat/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authController = Get.find<AuthController>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> onLogin() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      Get.find<AuthController>().login(username, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colorize().primaryFill,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: height,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.15),
                  color: Colorize().primaryFill,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const BrandName(),
                      const SizedBox(height: 20.0),
                      const BrandSlogan(),
                      const SizedBox(height: 30.0),
                      _InputTextField(
                        controller: _usernameController,
                        iconPath: 'assets/icons/user.svg',
                        hintText: 'Usuario',
                      ),
                      _spacer,
                      _InputTextField(
                        controller: _passwordController,
                        iconPath: 'assets/icons/password.svg',
                        hintText: 'Contraseña',
                        obscureText: true,
                      ),
                      _spacer,
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          style: ButtonStyle(
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                              vertical: 15.0,
                            )),
                            backgroundColor: MaterialStatePropertyAll(
                              Colorize().accentFill,
                            ),
                          ),
                          onPressed: () {
                            onLogin();
                          },
                          child: const Text('INGRESAR'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(() => Text(_authController.loginError.value,
                          style: const TextStyle(color: Colors.red))),
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
          ),
        ),
        Obx(() => _authController.isLoading.value
            ? const LoadingLayer()
            : const SizedBox())
      ],
    );
  }

  SizedBox get _spacer => const SizedBox(height: 20);
}

class _InputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String iconPath;
  final String? hintText;
  final bool obscureText;

  const _InputTextField(
      {required this.controller,
      required this.iconPath,
      this.hintText,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    const iconOpacity = 0.4;

    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(500.0)),
        child: TextFormField(
          controller: controller,
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colorize().bodyText.withOpacity(.4),
            ),
            enabledBorder:
                const UnderlineInputBorder(borderSide: BorderSide.none),
            focusedBorder:
                const UnderlineInputBorder(borderSide: BorderSide.none),
            prefixIcon: Opacity(
              opacity: iconOpacity,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0,
                ),
                child: SvgPicture.asset(
                  iconPath,
                  width: 15.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
