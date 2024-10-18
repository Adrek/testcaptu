part of 'widgets.dart';

class AnimatedToggle extends StatelessWidget {
  final String text;
  final ActionSliderController? controller;
  final Color textColor;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color arrowsColor;
  final SliderAction? action;
  final TextDirection? direction;

  const AnimatedToggle({
    super.key,
    required this.text,
    this.controller,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.black,
    this.foregroundColor = Colors.white,
    this.arrowsColor = Colors.black,
    this.action,
    this.direction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const forePadding = EdgeInsets.all(6);
    final globalRadius = BorderRadius.circular(18);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ActionSlider.custom(
          sliderBehavior: SliderBehavior.stretch,
          direction: direction,
          controller: controller,
          height: 65.0,
          toggleWidth: 75.0,
          toggleMargin: EdgeInsets.zero,
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(2, 3),
            )
          ],
          foregroundChild: _ForegroundChild(
            foregroundColor: foregroundColor,
            globalRadius: globalRadius,
            backgroundColor: backgroundColor,
            arrowsColor: arrowsColor,
            child: direction == TextDirection.rtl
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                    child: ArrowsAnimated(
                      color: arrowsColor,
                    ),
                  )
                : ArrowsAnimated(
                    color: arrowsColor,
                  ),
          ),
          foregroundBuilder: (context, state, child) {
            if (state.sliderMode == SliderMode.loading) {
              return Padding(
                padding: forePadding,
                child: _ForegroundChild(
                  foregroundColor: foregroundColor,
                  globalRadius: globalRadius,
                  backgroundColor: backgroundColor,
                  arrowsColor: arrowsColor,
                  child: FadeIn(
                    delay: const Duration(
                      milliseconds: 200,
                    ),
                    duration: const Duration(milliseconds: 150),
                    child: LoadingDotsSix(
                      color: arrowsColor,
                    ),
                  ),
                ),
              );
            }

            return Padding(
              padding: forePadding,
              child: child!,
            );
          },
          backgroundColor: backgroundColor,
          backgroundChild: Center(
            child: Text(
              text,
              style: theme.textTheme.titleMedium?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          backgroundBuilder: (context, state, child) => ClipRect(
              child: OverflowBox(
                  maxWidth: state.standardSize.width,
                  maxHeight: state.toggleSize.height,
                  minWidth: state.standardSize.width,
                  minHeight: state.toggleSize.height,
                  child: child!)),
          backgroundBorderRadius: globalRadius,
          /* action: (controller) async {
             controller.loading(); //starts loading animation
            await Future.delayed(const Duration(seconds: 3));
            controller.success(); //starts success animation
            await Future.delayed(const Duration(seconds: 1));
            controller.reset(); //resets the slider 
          },*/
          action: action,
        ),
      ],
    );
  }
}

class _ForegroundChild extends StatelessWidget {
  final Widget child;

  const _ForegroundChild({
    required this.foregroundColor,
    required this.globalRadius,
    required this.backgroundColor,
    required this.arrowsColor,
    required this.child,
  });

  final Color foregroundColor;
  final BorderRadius globalRadius;
  final Color backgroundColor;
  final Color arrowsColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: foregroundColor,
        borderRadius: globalRadius,
        boxShadow: [
          BoxShadow(
            color: ColorsUtils.darken(backgroundColor, .035),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(2, 2),
          )
        ],
      ),
      child: child,
    );
  }
}

class LoadingDotsSix extends StatelessWidget {
  final double size;
  final Color color;

  const LoadingDotsSix({
    super.key,
    this.size = 200,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          color: Colors.red,
          child: const SizedBox(),
        ),
        Positioned(
          right: -50,
          top: -30,
          bottom: -22,
          left: -62,
          child: Lottie.asset(
            'assets/lottie/loading_6.json',
            fit: BoxFit.cover,
            width: size,
            delegates: LottieDelegates(
              values: [
                for (var i in ['1', '2', '3'])
                  ValueDelegate.color(['Circle $i', '**'], value: color),
              ],
            ),
          ),
        )
      ],
    );
  }
}
