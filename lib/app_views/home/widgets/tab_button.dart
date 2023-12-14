import 'package:flutter/material.dart';
import 'package:talan_tools/talan_tools.dart';

class HomeTabButton extends StatelessWidget {
  const HomeTabButton({
    required this.groupValue,
    required this.value,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final int groupValue;
  final int value;
  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final isActive = groupValue == value;
    final textStyle = TextStyle(
      color: isActive
          ? Theme.of(context).textTheme.labelLarge?.color
          : Theme.of(context).scaffoldBackgroundColor,
    );
    final backgroundColor = isActive
        ? Theme.of(context).scaffoldBackgroundColor
        : Theme.of(context).appBarTheme.backgroundColor;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      constraints: const BoxConstraints(minWidth: 150),
      child: TextButton(
        style: const ButtonStyle(
          padding: MaterialStatePropertyAll<EdgeInsetsGeometry?>(
            EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 10,
            ),
          ),
          shadowColor: MaterialStatePropertyAll<Color>(Colors.transparent),
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent),
          overlayColor: MaterialStatePropertyAll<Color>(Colors.transparent),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: textStyle,
        ),
      ),
    );
  }
}

class HomeTabDrawerButton extends StatelessWidget {
  const HomeTabDrawerButton({
    required this.groupValue,
    required this.value,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final int groupValue;
  final int value;
  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final isActive = groupValue == value;
    final textStyle = TextStyle(
      color: Theme.of(context).colorScheme.onBackground,
      fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
    );
    return TextButton(
      onPressed: onPressed,
      child: TalanText.bodyLarge(
        text: label,
        style: textStyle,
      ),
    );
  }
}
