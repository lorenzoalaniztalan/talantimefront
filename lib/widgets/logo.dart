import 'package:flutter/material.dart';

/// Widget for displaying the different logos
class Logo extends StatelessWidget {
  const Logo({
    super.key,
    this.height = 48,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.variant = LogoVariant.talantime,
  });
  final double? height;
  final LogoVariant variant;
  final BoxFit fit;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    var path = '';
    switch (variant) {
      case LogoVariant.talantime:
        path = 'assets/img/logo.png';
      case LogoVariant.talantimeWhite:
        path = 'assets/img/logo_white.png';
      case LogoVariant.talantimeIcon:
        path = 'assets/img/logo_icon_filled.png';
      case LogoVariant.talantimeIconInset:
        path = 'assets/img/logo_icon_inset.png';
      case LogoVariant.talan:
        path = 'assets/img/talanLogo.png';
    }
    return Image.asset(
      path,
      height: height,
    );
  }
}

enum LogoVariant {
  talantime,
  talantimeWhite,
  talantimeIcon,
  talantimeIconInset,
  talan,
}
