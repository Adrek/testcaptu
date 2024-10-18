import 'package:app_captusiat/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageBackup extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPageBackup({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    _usernameController.text = 'alec';
    _passwordController.text = 'alec';

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: "Username"),
                    onTapOutside: (_) {},
                  ),
                  TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: "Password"),
                      obscureText: true),
                  ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      authController.login(
                          _usernameController.text, _passwordController.text);
                    },
                    child: Obx(() => authController.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text("Login")),
                  ),
                  Obx(() => Text(authController.loginError.value ?? '',
                      style: const TextStyle(color: Colors.red))),
                ],
              ),
            ),
            Positioned.fill(
              child: Obx(
                () => authController.isLoading.value
                    ? Container(
                        color: Colors.indigo.withOpacity(.76),
                        child: const Center(
                            child: Text(
                          'Cargando...',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                      )
                    : const SizedBox(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
