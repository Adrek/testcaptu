import 'package:animate_do/animate_do.dart';
import 'package:app_captusiat/core/theme/app_theme.dart';
import 'package:app_captusiat/core/utils/utils.dart';
import 'package:app_captusiat/features/alerting/alerting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

final akSOSColor = Colorize().primaryFill;

class AlertingPage extends StatelessWidget {
  final _conX = Get.put(HomeAlertingController());

  AlertingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    akSOSColor,
                    akSOSColor,
                    ColorsUtils.darken(akSOSColor, 0.1),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        _CircleRadarOutlined(
                          _conX.animOutlinedCtlr,
                          size: Get.width * 1.5,
                        ),
                        _CircleRadarOutlined(
                          _conX.animOutlinedCtlr2,
                          size: Get.width * 1.5,
                        ),
                        /* BtnSOS(
                          heroTag: 'btnSOS',
                          size: Get.width * 0.5,
                          text: 'SOS',
                          alertStyle: true,
                          animatedText: true,
                        ), */
                        // Text('data'),
                        Positioned.fill(
                          child: Obx(
                            () => AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: _conX.showAlertLottie.value
                                    ? Container(
                                        padding:
                                            EdgeInsets.all(Get.width * 0.1),
                                        child: Center(
                                          child: Lottie.asset(
                                              'assets/lottie/alert_radar.json',
                                              fit: BoxFit.fill,
                                              delegates: LottieDelegates(
                                                values: [
                                                  for (var i in ['1', '2', '5'])
                                                    ValueDelegate.color([
                                                      'Layer $i Outlines',
                                                      '**'
                                                    ],
                                                        value:
                                                            ColorsUtils.lighten(
                                                                akSOSColor)),
                                                  for (var i in ['3', '4'])
                                                    ValueDelegate.color(
                                                      [
                                                        'Layer $i Outlines',
                                                        '**'
                                                      ],
                                                      value:
                                                          ColorsUtils.lighten(
                                                              akSOSColor, 0.3),
                                                    ),
                                                ],
                                              )),
                                        ),
                                      )
                                    : const SizedBox()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 300),
                    child: _MainText(conX: _conX),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleRadarOutlined extends AnimatedWidget {
  final double size;

  const _CircleRadarOutlined(Animation<double> animation, {this.size = 200.0})
      : super(listenable: animation);

  double get value => (listenable as Animation).value;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -Get.width * 10,
      bottom: -Get.width * 10,
      left: -Get.width * 10,
      right: -Get.width * 10,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorsUtils.lighten(akSOSColor, 0.1),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(1000),
          ),
          width: value,
          height: value,
        ),
      ),
    );
  }
}

class _MainText extends StatelessWidget {
  final HomeAlertingController conX;

  const _MainText({required this.conX});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() => AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                conX.mainMessage.value,
                key: ValueKey('vkSosMsg_${conX.mainMessage.value}'),
                style: const TextStyle(
                  fontSize: 12.0 + 5.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
        const SizedBox(height: 10.0),
        Text(
          'No cierre la aplicación',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.white.withOpacity(.60),
          ),
        ),
      ],
    );
  }
}
