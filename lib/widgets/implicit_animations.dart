import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class FadePanInWidget extends StatelessWidget {
  const FadePanInWidget({
    required this.child,
    super.key,
    this.index = 0,
    this.delay = 0,
  });

  final Widget child;
  final int index;
  final int delay;

  @override
  Widget build(BuildContext context) {
    final animationDelay = delay == 0 ? null : Duration(milliseconds: delay);
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: _animationDuration,
      child: SlideAnimation(
        curve: _animationCurve,
        delay: animationDelay,
        verticalOffset: 40,
        child: FadeInAnimation(
          delay: animationDelay,
          child: child,
        ),
      ),
    );
  }
}

const _animationDuration = Duration(milliseconds: 400);
const _animationCurve = Curves.fastOutSlowIn;
