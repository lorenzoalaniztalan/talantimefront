import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/providers/locale_provider.dart';

class TalanSwitchTheme extends StatelessWidget {
  const TalanSwitchTheme({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Consumer<TalanThemeProvider>(
      builder: (context, provider, child) {
        final bottom = provider.mode == ThemeMode.light ? 0.0 : -_size;
        final mainColor = color ?? Theme.of(context).scaffoldBackgroundColor;
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: _size,
            maxHeight: _size,
            minWidth: _size,
            maxWidth: _size,
          ),
          child: SizedBox(
            height: _size,
            width: _size,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: provider.toggleThemeMode,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      bottom: bottom,
                      child: SizedBox(
                        width: _size,
                        height: _size * 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.nightlight_round,
                              size: 20,
                              color: mainColor,
                            ),
                            Icon(
                              Icons.wb_sunny_sharp,
                              size: 20,
                              color: mainColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

double _size = 30;

class SwitchLang extends StatelessWidget {
  const SwitchLang({this.color, super.key});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Theme.of(context).scaffoldBackgroundColor;
    const fullHeight = 26.0;
    const fullWidth = 48.0;
    const fontSize = 10.0;
    return Consumer<LocaleProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          height: fullHeight,
          width: fullWidth,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'EN',
                    style: TextStyle(
                      color: color,
                      fontSize: fontSize,
                    ),
                  ),
                  Text(
                    'ES',
                    style: TextStyle(
                      color: color,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: Provider.of<LocaleProvider>(context, listen: false)
                      .toggleLocale,
                  child: Container(
                    height: fullHeight - 2,
                    width: fullWidth - 2,
                    decoration: ShapeDecoration(
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: color,
                        ),
                      ),
                    ),
                    child: AnimatedAlign(
                      alignment: provider.locale.languageCode == 'es'
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.fastOutSlowIn,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                        ),
                        child: Container(
                          height: fullHeight - 6,
                          width: fullWidth / 2 - 0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
