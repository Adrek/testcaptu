part of 'widgets.dart';

class VersionLateralBar extends StatelessWidget {
  const VersionLateralBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 50,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        decoration: BoxDecoration(
            color: Colorize().accentFill,
            borderRadius:
                const BorderRadius.horizontal(right: Radius.circular(20.0))),
        child: const Opacity(
          opacity: .6,
          child: Text(
            'v 1.0.0',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
      ),
    );
  }
}
