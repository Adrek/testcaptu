part of 'widgets.dart';

class BrandSlogan extends StatelessWidget {
  final double textSize;

  const BrandSlogan({super.key, this.textSize = 18.0});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Text(
      'Aplicación para geolocalización de personal',
      textAlign: TextAlign.center,
      style: textTheme.bodyMedium
          ?.copyWith(color: Colors.white, fontSize: textSize),
    );
  }
}
