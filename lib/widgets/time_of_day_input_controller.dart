import 'package:flutter/material.dart';
import 'package:talan_tools/talan_tools.dart';

class TimeOfDayFormField extends FormField<TimeOfDay> {
  TimeOfDayFormField({
    required String label,
    String? displayError,
    void Function(TimeOfDay value)? onChanged,
    super.initialValue,
    super.key,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
  }) : super(
          builder: (
            state,
          ) {
            final canEdit = onChanged != null;
            final mainColor = Theme.of(state.context).primaryColor;
            const errorColor = TalanAppColors.error;
            const backInputColor = TalanAppColors.n400;
            final localizations = MaterialLocalizations.of(state.context);
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TalanText.bodyLarge(
                      text: label,
                    ),
                    TalanTouchable(
                      onPress: canEdit
                          ? () async {
                              final res = await showTimePicker(
                                context: state.context,
                                initialTime: state.value ??
                                    const TimeOfDay(hour: 0, minute: 0),
                              );
                              if (res != null) {
                                state.didChange(res);
                                onChanged(res);
                              }
                            }
                          : null,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: canEdit
                                ? (displayError == null
                                    ? mainColor
                                    : errorColor)
                                : Colors.transparent,
                          ),
                          color: canEdit ? Colors.transparent : backInputColor,
                        ),
                        child: SizedBox(
                          width: 60,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Text(
                                localizations.formatTimeOfDay(
                                  state.value ??
                                      const TimeOfDay(hour: 0, minute: 0),
                                  alwaysUse24HourFormat: true,
                                ),
                                style: TextStyle(
                                  color: canEdit
                                      ? (displayError == null
                                          ? mainColor
                                          : errorColor)
                                      : (Theme.of(state.context)
                                          .colorScheme
                                          .onBackground),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: displayError != null,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3.5, bottom: 4),
                      child: TalanText.bodySmall(
                        text:
                            displayError ?? state.errorText ?? 'Invalid value',
                        style: (Theme.of(state.context)
                                    .inputDecorationTheme
                                    .errorStyle ??
                                const TextStyle())
                            .copyWith(
                          color: errorColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
}
