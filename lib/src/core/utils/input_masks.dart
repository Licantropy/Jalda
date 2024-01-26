import 'package:flutter/services.dart';

/// `CustomMaskTextInputFormatter` is a `TextInputFormatter` for Flutter that
/// allows text input to be formatted based on a specified mask pattern.
/// It's especially useful for formatting structured inputs like phone numbers, credit cards, etc.
class CustomMaskTextInputFormatter extends TextInputFormatter {
  /// `mask` is a String representing the format pattern.
  /// The character '#' is used as a placeholder for user input.
  final String mask;

  /// `filter` is a Map where each key represents a character in the `mask`.
  /// The corresponding RegExp determines the allowed characters for that position.
  final Map<String, RegExp> filter;

  /// Constructs a `CustomMaskTextInputFormatter` with the provided `mask` and `filter`.
  CustomMaskTextInputFormatter({required this.mask, required this.filter});

  /// Factory constructor to create a phone number formatter.
  /// Sets up a formatter for a standard phone number format.
  factory CustomMaskTextInputFormatter.phoneFormatter() => CustomMaskTextInputFormatter(
    mask: '+# (###) ###-##-##',
    filter: {"#": RegExp('[0-9]')},
  );

  /// Overrides `TextInputFormatter.formatEditUpdate`.
  /// Formats the `newValue` of the text field based on the `mask` and `filter`.
  /// It processes each character of the `newValue` and applies the mask,
  /// skipping characters that do not match the corresponding filter RegExp.
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    String newText = '';
    int j = 0;

    for (int i = 0; i < mask.length && j < newValue.text.length; i++) {
      if (mask[i] == '#') {
        while (j < newValue.text.length && !filter['#']!.hasMatch(newValue.text[j])) {
          j++;
        }
        if (j < newValue.text.length) {
          newText += newValue.text[j];
          j++;
        }
      } else {
        if (j < newValue.text.length || mask[i] != '#') {
          newText += mask[i];
        }
      }
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
