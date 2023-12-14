import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/l10n/l10n.dart';

/// Multiple select
class MultiSelect extends StatelessWidget {
  const MultiSelect({
    required this.label,
    required this.values,
    required this.hint,
    required this.onChanged,
    required this.options,
    super.key,
    this.validator,
    this.required = false,
  });
  final String label;
  final List<dynamic> values;
  final String hint;
  final List<MultiSelectItem<dynamic>> options;
  final String? Function(String?)? validator;
  final void Function(List<dynamic>?) onChanged;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          await showDialog<void>(
            context: context,
            builder: (ctx) {
              final theme = Theme.of(context);
              final colorScheme = theme.colorScheme;
              final itemsTextStyles =
                  TextStyle(color: theme.textTheme.titleSmall?.color);
              return MultiSelectDialog(
                title: Text(
                  label,
                ),
                backgroundColor: colorScheme.background,
                cancelText: Text(
                  l10n.cancel,
                ),
                confirmText: Text(
                  l10n.ok,
                ),
                searchIcon: Icon(Icons.search, color: TalanAppColors.primary),
                closeSearchIcon:
                    Icon(Icons.close, color: TalanAppColors.primary),
                selectedColor: TalanAppColors.primary,
                unselectedColor: theme.disabledColor,
                itemsTextStyle: itemsTextStyles,
                selectedItemsTextStyle: itemsTextStyles,
                width: 400,
                height: 520,
                separateSelectedItems: true,
                items: options,
                initialValue: values,
                onConfirm: onChanged,
                searchable: true,
              );
            },
          );
        },
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              label: Text(label),
              suffixIcon: Icon(
                Icons.arrow_drop_down,
                size: 24,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white70
                    : Colors.grey.shade700,
              ),
            ),
            key: ValueKey(values.hashCode),
            initialValue: values
                .map(
                  (e) =>
                      options.firstWhere((element) => element.value == e).label,
                )
                .join(', '),
            readOnly: true,
            showCursor: false,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
            validator: (val) {
              return validator?.call(values.join(', '));
            },
          ),
        ),
      ),
    );
  }
}
