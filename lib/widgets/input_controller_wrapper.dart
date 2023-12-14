import 'package:flutter/material.dart';
import 'package:talan_tools/talan_tools.dart';

class InputControllerSpaceError extends StatelessWidget {
  const InputControllerSpaceError({
    required this.child,
    required this.hasError,
    super.key,
  });
  final bool hasError;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: hasError ? 7.5 : spacerL.height!),
      child: child,
    );
  }
}
