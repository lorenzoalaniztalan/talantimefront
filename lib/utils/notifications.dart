import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/widgets/notifications.dart';

class NotificationHandler {
  static void showToast(
    BuildContext context,
    String message, {
    bool isError = true,
  }) {
    showSimpleNotification(
      Text(message),
      contentPadding: EdgeInsets.symmetric(
        horizontal: TalanAppDimensions.innerGap * 2,
        vertical: TalanAppDimensions.innerGap / 2,
      ),
      duration: const Duration(seconds: 4),
      slideDismissDirection: DismissDirection.up,
      background: isError ? TalanAppColors.error : TalanAppColors.success,
    );
  }

  static void showToastWithoutContext({String? message, bool isError = true}) {
    if (message.runtimeType == String) {
      showOverlay(
        (context, progress) => TalanNotification(
          progress: progress,
          message: message!,
          isError: isError,
          key: ValueKey('NotificationOverlayMessage$message'),
        ),
        duration: const Duration(seconds: 5),
        key: const ValueKey('NotificationOverlay'),
      );
    } else {
      showOverlay(
        (context, progress) => const SizedBox.shrink(),
        duration: Duration.zero,
        key: const ValueKey('NotificationOverlay'),
      );
    }
  }
}

void handleSuccess(String message) {
  NotificationHandler.showToastWithoutContext(message: message, isError: false);
}

void handleError(String message) {
  NotificationHandler.showToastWithoutContext(message: message);
}

void handleHideNotification() {
  NotificationHandler.showToastWithoutContext(isError: false);
}
