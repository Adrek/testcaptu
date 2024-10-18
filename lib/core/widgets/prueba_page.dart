part of 'widgets.dart';

class PruebaPage extends StatefulWidget {
  const PruebaPage({super.key});

  @override
  State<PruebaPage> createState() => _PruebaPageState();
}

class _PruebaPageState extends State<PruebaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedToggle(
              text: 'Iniciar el viaje',
              backgroundColor: Color(0xFF00937A),
              foregroundColor: Colors.white,
              arrowsColor: Color(0xFF00937A),
            ),
          ],
        ),
      ),
    );
  }
}
