part of 'widgets.dart';

class SwitcherButton extends StatelessWidget {
  final bool esUnido;
  final VoidCallback? onTap;

  const SwitcherButton({super.key, this.esUnido = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15.0);
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: esUnido ? Colorize().accentFill : Colors.white,
          borderRadius: borderRadius,
        ),
        child: Row(
          children: [
            esUnido
                ? const SizedBox()
                : const _ButtonIcon(
                    iconPath: 'assets/icons/switcher_arrow.svg',
                  ),
            Expanded(
              child: Text(
                esUnido ? 'Unido a operativo' : 'Unirse a operativo',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                  color: esUnido
                      ? Colors.white
                      : Colorize().accentFill.withOpacity(.45),
                ),
              ),
            ),
            esUnido
                ? _ButtonIcon(
                    iconPath: 'assets/icons/switcher_check.svg',
                    esUnido: esUnido,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _ButtonIcon extends StatelessWidget {
  final bool esUnido;

  final String? iconPath;

  const _ButtonIcon({
    this.iconPath,
    this.esUnido = false,
  });

  @override
  Widget build(BuildContext context) {
    const size = 50.0;

    return Stack(
      children: [
        Container(
          height: size,
          width: size * .9,
          decoration: BoxDecoration(
            color: esUnido ? Colors.white : Colorize().accentFill,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const SizedBox(),
        ),
        Positioned.fill(
            child: Center(
          child: iconPath != null
              ? SvgPicture.asset(
                  iconPath!,
                  colorFilter: ColorFilter.mode(
                    esUnido ? Colorize().accentFill : Colors.white,
                    BlendMode.srcIn,
                  ),
                )
              : const SizedBox(),
        ))
      ],
    );
  }
}
