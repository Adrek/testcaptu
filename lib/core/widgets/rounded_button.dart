part of 'widgets.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const RoundedButton({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            vertical: 0.0,
            horizontal: 20.0,
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(
          Colorize().accentFill,
        ),
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
