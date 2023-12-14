import 'package:flutter/material.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/welcome/widgets/section.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/widgets/implicit_animations.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: TalanAppDimensions.pageInsetGap,
              ),
              child: Column(
                children: [
                  spacerL,
                  Section(
                    imagePath: 'assets/img/home_section_1.jpg',
                    title: l10n.homePageWelcomeTitleOne,
                    subtititle1: l10n.homePageWelcomeOneSubtitleOne,
                    subtititle2: l10n.homePageWelcomeOneSubtitleTwo,
                    imageFirst: false,
                  ),
                  sectionSpacer,
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Column(
                      children: [
                        FadePanInWidget(
                          index: 3,
                          child: TalanText.headlineMedium(
                            text: l10n.homePageWelcomeTitleTwo,
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.labelLarge?.color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        spacerL,
                        FadePanInWidget(
                          index: 4,
                          child: TalanText.bodyLarge(
                            text: l10n.homePageWelcomeTwoSubtitleOne,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        spacerM,
                        FadePanInWidget(
                          index: 5,
                          child: TalanText.bodyLarge(
                            text: l10n.homePageWelcomeTwoSubtitleTwo,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  sectionSpacer,
                  Section(
                    imagePath: 'assets/img/home_section_2.jpg',
                    title: l10n.homePageWelcomeTitleThree,
                    subtititle1: l10n.homePageWelcomeThreeSubtitleOne,
                    subtititle2: l10n.homePageWelcomeThreeSubtitleTwo,
                    imageFirst: true,
                    offset: 4,
                  ),
                  sectionSpacer,
                  FadePanInWidget(
                    index: 5,
                    child: TalanText.displayMedium(
                      text: l10n.homePageWelcomeTitleFour,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.labelLarge?.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  sectionSpacer,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const sectionSpacer = TalanSpacer(
  size: 90,
);
