part of 'widgets.dart';

class BrandName extends StatelessWidget {
  final double textSize;

  const BrandName({super.key, this.textSize = 32.0});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return RichText(
      text: TextSpan(
          text: 'CAPTU',
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontSize: textSize,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
              text: 'SIAT',
              style: textTheme.bodyMedium?.copyWith(
                color: Colorize().accentFill,
                fontSize: textSize,
                fontWeight: FontWeight.w600,
              ),
            )
          ]),
    );
  }
}
