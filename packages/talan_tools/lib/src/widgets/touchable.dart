import 'package:flutter/material.dart';

/// Widget for wrapping any other widget and give it onPress interaction
class TalanTouchable extends StatelessWidget {
  /// Constructor
  const TalanTouchable({required this.child, this.onPress, super.key});

  /// Child widget
  final Widget child;

  /// onPress callback
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPress,
        child: child,
      ),
    );
  }
}
