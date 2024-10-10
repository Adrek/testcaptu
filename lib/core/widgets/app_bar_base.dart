part of 'widgets.dart';

class AppBarBase extends StatelessWidget {
  final Widget child;
  final VoidCallback? onBackTap;
  final String? title;
  final String? subTitle;

  const AppBarBase({
    super.key,
    required this.child,
    this.onBackTap,
    this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(40.0),
      ),
      child: Container(
        width: double.infinity,
        // height: height * .3,
        decoration: BoxDecoration(
          color: Colorize().primaryFill,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: .5,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/app_overlay.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colorize().primaryFill.withOpacity(.83),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: Content.padding,
                vertical: 0.0,
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (onBackTap != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Transform.translate(
                                offset: const Offset(-16, 0),
                                child: IconButton(
                                  onPressed: onBackTap,
                                  icon: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    if (title != null)
                      Text(
                        title!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 24.0,
                        ),
                      ),
                    if (subTitle != null)
                      Text(
                        subTitle!,
                        style: TextStyle(
                          color: Colorize().bodySubtitleDark,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                    child,
                    const SizedBox(height: Content.padding * 1),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
