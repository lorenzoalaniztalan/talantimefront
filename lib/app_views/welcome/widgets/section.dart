import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/widgets/implicit_animations.dart';

class Section extends StatelessWidget {
  const Section({
    required this.imagePath,
    required this.title,
    required this.subtititle1,
    required this.subtititle2,
    required this.imageFirst,
    this.offset = 0,
    super.key,
  });
  final String imagePath;
  final String title;
  final String subtititle1;
  final String subtititle2;
  final bool imageFirst;
  final int offset;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1020),
      child: ResponsiveBreakpoints.of(context).largerThan(TABLET)
          ? _DesktopSection(
              imagePath: imagePath,
              title: title,
              subtititle1: subtititle1,
              subtititle2: subtititle2,
              imageFirst: imageFirst,
              offset: offset,
            )
          : _MobileSection(
              imagePath: imagePath,
              title: title,
              subtititle1: subtititle1,
              subtititle2: subtititle2,
              imageFirst: imageFirst,
              offset: offset,
            ),
    );
  }
}

class _DesktopSection extends StatelessWidget {
  const _DesktopSection({
    required this.imagePath,
    required this.title,
    required this.subtititle1,
    required this.subtititle2,
    required this.imageFirst,
    this.offset = 0,
  });
  final String imagePath;
  final String title;
  final String subtititle1;
  final String subtititle2;
  final bool imageFirst;
  final int offset;

  @override
  Widget build(BuildContext context) {
    final children = [
      Expanded(
        flex: 5,
        child: Column(
          crossAxisAlignment:
              imageFirst ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            FadePanInWidget(
              index: offset + 1,
              child: TalanText.headlineMedium(
                text: title,
                style: TextStyle(
                  color: Theme.of(context).textTheme.labelLarge?.color,
                ),
              ),
            ),
            spacerL,
            FadePanInWidget(
              index: offset + 2,
              child: TalanText.bodyLarge(
                text: subtititle1,
                textAlign: imageFirst ? TextAlign.right : TextAlign.left,
              ),
            ),
            spacerM,
            FadePanInWidget(
              index: offset + 3,
              child: TalanText.bodyLarge(
                text: subtititle2,
                textAlign: imageFirst ? TextAlign.right : TextAlign.left,
              ),
            ),
          ],
        ),
      ),
      spacerL,
      Expanded(
        flex: 4,
        child: FadePanInWidget(
          index: offset + 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              TalanAppDimensions.borderRadiusControllers,
            ),
            child: AspectRatio(
              aspectRatio: 43 / 26,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      )
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: (imageFirst ? children.reversed : children).toList(),
    );
  }
}

class _MobileSection extends StatelessWidget {
  const _MobileSection({
    required this.imagePath,
    required this.title,
    required this.subtititle1,
    required this.subtititle2,
    required this.imageFirst,
    this.offset = 0,
  });
  final String imagePath;
  final String title;
  final String subtititle1;
  final String subtititle2;
  final bool imageFirst;
  final int offset;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          imageFirst ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        FadePanInWidget(
          index: offset + 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              TalanAppDimensions.borderRadiusControllers,
            ),
            child: AspectRatio(
              aspectRatio: 43 / 26,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        spacerL,
        FadePanInWidget(
          index: offset + 2,
          child: TalanText.headlineMedium(
            text: title,
            style: TextStyle(
              color: Theme.of(context).textTheme.labelLarge?.color,
            ),
          ),
        ),
        spacerL,
        FadePanInWidget(
          index: offset + 3,
          child: TalanText.bodyLarge(
            text: subtititle1,
            textAlign: imageFirst ? TextAlign.right : TextAlign.left,
          ),
        ),
        spacerM,
        FadePanInWidget(
          index: offset + 4,
          child: TalanText.bodyLarge(
            text: subtititle2,
            textAlign: imageFirst ? TextAlign.right : TextAlign.left,
          ),
        ),
      ],
    );
  }
}
