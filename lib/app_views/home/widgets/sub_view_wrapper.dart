import 'package:flutter/material.dart';
import 'package:talan_tools/talan_tools.dart';

class HomePageSubViewWrapper extends StatelessWidget {
  const HomePageSubViewWrapper({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(TalanAppDimensions.pageInsetGap)
              .copyWith(top: spacerL.height),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1020,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
