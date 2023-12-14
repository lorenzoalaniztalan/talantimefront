import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/utils/notifications.dart';

class TalanNotification extends StatelessWidget {
  const TalanNotification({
    required this.progress,
    required this.message,
    this.isError = false,
    super.key,
  });
  final double progress;

  final String message;

  final bool isError;

  @override
  Widget build(BuildContext context) {
    var icon = Icons.check_circle;
    var backgroundColor = Colors.green.shade100;
    var mainColor = TalanAppColors.success;
    var alignment = Alignment.topCenter;
    var fromOffset = const Offset(0, -2);
    const toOffset = Offset.zero;
    if (isError) {
      icon = Icons.error_rounded;
      backgroundColor = Colors.red.shade100;
      mainColor = TalanAppColors.error;
    }
    if (ResponsiveBreakpoints.of(context).largerThan(TABLET)) {
      alignment = Alignment.bottomRight;
      fromOffset = const Offset(2, 0);
    }
    return Material(
      color: Colors.transparent,
      type: MaterialType.transparency,
      child: Padding(
        padding: EdgeInsets.only(
          right: TalanAppDimensions.innerGap,
          left: TalanAppDimensions.innerGap,
          top: TalanAppDimensions.innerGap,
          bottom: TalanAppDimensions.innerGap + kToolbarHeight,
        ),
        child: Align(
          alignment: alignment,
          child: FractionalTranslation(
            translation: Offset.lerp(fromOffset, toOffset, progress)!,
            child: AnimatedOpacity(
              opacity: 1,
              duration: const Duration(milliseconds: 200),
              child: GestureDetector(
                onTap: handleHideNotification,
                child: _NotificationView(
                  message: message,
                  icon: icon,
                  mainColor: mainColor,
                  backgroundColor: backgroundColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationView extends StatelessWidget {
  const _NotificationView({
    required this.message,
    required this.icon,
    required this.mainColor,
    required this.backgroundColor,
  });
  final String message;
  final IconData icon;
  final Color mainColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          TalanAppDimensions.borderRadiusControllers,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(TalanAppDimensions.innerGap),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: mainColor,
              size: 18,
            ),
            spacerS,
            TalanText.bodyMedium(
              text: message,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: mainColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
