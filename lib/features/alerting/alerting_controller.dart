import 'dart:async';

import 'package:app_captusiat/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAlertingController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController animOutlinedCtlr;
  late AnimationController animOutlinedCtlr2;

  final mainMessage = 'Enviando ubicación...'.obs;

  // Timers
  Timer? _timerSosTxt;
  final showAlertLottie = false.obs;

  @override
  void onInit() {
    super.onInit();

    _init();
  }

  @override
  void onClose() {
    _timerSosTxt?.cancel();
    animOutlinedCtlr.dispose();
    animOutlinedCtlr2.dispose();

    super.onClose();
  }

  Future<void> _init() async {
    animOutlinedCtlr = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      lowerBound: 400,
      upperBound: 600,
    );

    animOutlinedCtlr2 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      lowerBound: 500,
      upperBound: 700,
    );

    animOutlinedCtlr.repeat();
    // await Helpers.sleep(1000);
    animOutlinedCtlr2.repeat();

    _startSosChangeAnimation();
  }

  Future<void> _startSosChangeAnimation() async {
    await Helpers.sleep(1000);
    _toggleSOSLottie();
    await Helpers.sleep(2000);
    _toggleSOSLottie();

    _timerSosTxt?.cancel();
    _timerSosTxt = Timer.periodic(const Duration(milliseconds: 2000), (_) {
      _toggleSOSLottie();
    });
  }

  void _toggleSOSLottie() {
    showAlertLottie.value = !showAlertLottie.value;
  }
}
