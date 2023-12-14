import 'package:flutter/material.dart';

/// Dummy widget for filling spaces
class TalanSpacer extends StatelessWidget {
  /// Dummy widget for filling spaces
  const TalanSpacer({super.key, this.size = 20});

  /// Width and height for this spacer
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
    );
  }
}

/// Dummy widget for filling spaces. Size 0.
const spacerZero = SizedBox.shrink();

/// Dummy widget for filling spaces. Expanded.
const spacerExpanded = Expanded(child: spacerZero);

/// Dummy widget for filling spaces. Size 5.
const spacerXs = SizedBox(
  height: 5,
  width: 5,
);

/// Dummy widget for filling spaces. Size 12.
const spacerS = SizedBox(
  height: 12,
  width: 12,
);

/// Dummy widget for filling spaces. Size 20.
const spacerM = SizedBox(
  height: 20,
  width: 20,
);

/// Dummy widget for filling spaces. Size 30.
const spacerL = SizedBox(
  height: 30,
  width: 30,
);

/// Dummy widget for filling spaces. Size 40.
const spacerXL = SizedBox(
  height: 40,
  width: 40,
);
