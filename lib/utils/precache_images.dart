import 'package:flutter/material.dart';

Future<void> precacheAssetImages(BuildContext context) async {
  await Future.wait(
    _assetImages.map(
      (asset) => precacheImage(AssetImage('assets/img/$asset'), context),
    ),
  );
}

const _assetImages = [
  'login_background_mobile.png',
  'login_side_panel.png',
  'logo_white.png',
  'logo.png',
  'register_background_mobile.png',
  'register_side_panel.png',
  'home_section_1.jpg',
  'home_section_2.jpg',
];
