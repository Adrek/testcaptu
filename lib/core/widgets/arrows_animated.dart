part of 'widgets.dart';

class ArrowsAnimated extends StatefulWidget {
  final Color color;
  final double size;

  const ArrowsAnimated({
    super.key,
    this.color = Colors.black,
    this.size = 20,
  });

  @override
  State<ArrowsAnimated> createState() => _ArrowsAnimatedState();
}

class _ArrowsAnimatedState extends State<ArrowsAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _arrowAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _arrowAnimation = Tween<double>(begin: 1.0, end: 0.15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.90, // La primera flecha permanecerá al 100% durante el 30% del tiempo
          curve: Curves.linear,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Liberar el controlador cuando el widget se destruya
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arrowIcon = SvgPicture.asset(
      'assets/icons/switcher_arrow.svg',
      width: widget.size,
      colorFilter: ColorFilter.mode(
        widget.color,
        BlendMode.srcIn,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: widget.size * 1.5,
          height: widget.size,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.transparent),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                ),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _arrowAnimation.value,
                      child: arrowIcon,
                    );
                  },
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: -widget.size * 0.45,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent)),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: 1.15 -
                            _arrowAnimation.value, // Invierte la animación
                        child: arrowIcon,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
