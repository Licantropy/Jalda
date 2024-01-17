import 'package:flutter/material.dart';

/// A custom text form field widget for use in forms.
///
/// This widget wraps a `TextFormField` providing additional customization and styling.
/// It is typically used within a form to allow users to input text data.
class AppTextFormField extends StatelessWidget {
  /// Controls the text being edited.
  ///
  /// If the [controller] is null, this widget will create its own [TextEditingController].
  final TextEditingController controller;

  /// Text that suggests what sort of input the field accepts.
  ///
  /// Displayed on top of the `TextFormField` when it is empty and unfocused.
  final String? hintText;

  /// An optional widget to display before the text input.
  ///
  /// This can be an icon or any other widget to appear at the beginning of the text field.
  final Widget? prefixIcon;

  /// An optional widget to display after the text input.
  ///
  /// This can be an icon or any other widget to appear at the end of the text field.
  final Widget? suffixIcon;

  /// The maximum number of characters (Unicode scalar values) to allow in the text field.
  ///
  /// If null, there is no limit to the number of characters.
  final int? maxLength;

  /// Function that returns a string error message if the input is invalid.
  ///
  /// If the input is valid, it should return null.
  final String? Function(String?) validator;

  /// Creates an instance of [AppTextFormField].
  const AppTextFormField({
    required this.controller,
    required this.validator,
    super.key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        maxLength: maxLength,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color.fromRGBO(232, 232, 232, 1), width: 1.5),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
}
