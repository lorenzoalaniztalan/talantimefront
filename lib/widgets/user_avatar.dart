import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:user_api/user_api.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    required this.user,
    this.photo,
    this.inverted = false,
    this.fontSize = 14,
    super.key,
  });
  final User user;
  final XFile? photo;
  final bool inverted;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    if (photo != null) {
      return FutureBuilder<Uint8List>(
        future: photo!.readAsBytes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          final data = snapshot.data!;
          return DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: Image.memory(data).image,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      );
    }
    final primary = TalanAppColors.primary;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    final mainColor = inverted ? scaffoldBackgroundColor : primary;
    final backgroundColor = inverted ? primary : scaffoldBackgroundColor;
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          user.initials,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: mainColor,
          ),
        ),
      ),
    );
  }
}
