import 'package:flutter/material.dart';
import 'package:talan_tools/talan_tools.dart';

class TalanErrorWidget extends StatelessWidget {
  const TalanErrorWidget({super.key, this.message = 'There was an error'});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error,
              color: TalanAppColors.error,
            ),
            spacerXs,
            TalanText.headlineLarge(text: 'Ups')
          ],
        ),
        spacerXs,
        TalanText.bodyLarge(text: message),
      ],
    );
  }
}
