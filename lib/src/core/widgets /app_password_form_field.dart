import 'package:flutter/material.dart';

/// A custom password form field widget for use in forms.
///
/// This widget wraps a `TextFormField` providing additional customization
/// for password fields, including an option to toggle visibility of the input.
/// It supports customization such as hintText, prefixIcon, maxLength, etc.
class AppPasswordFormField extends StatefulWidget {
  /// Controls the text being edited for password.
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
  /// If null, a visibility toggle icon is provided by default.
  final Widget? suffixIcon;

  /// The maximum number of characters (Unicode scalar values) to allow in the text field.
  ///
  /// If null, there is no limit to the number of characters.
  final int? maxLength;

  /// Function that returns a string error message if the input is invalid.
  ///
  /// If the input is valid, it should return null.
  final String? Function(String?) validator;

  /// The type of keyboard to use for editing the text.
  ///
  /// Defaults to `TextInputType.text` if not provided.
  final TextInputType? keyboardType;

  /// Creates an instance of [AppPasswordFormField].
  ///
  /// This constructor requires a [TextEditingController] and a [validator] function,
  /// while other parameters are optional and allow further customization.
  const AppPasswordFormField({
    required this.controller,
    required this.validator,
    super.key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.keyboardType,
  });

  @override
  State<AppPasswordFormField> createState() => _AppPasswordFormFieldState();
}

class _AppPasswordFormFieldState extends State<AppPasswordFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.controller,
        maxLength: widget.maxLength,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        obscureText: _isObscure,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon ??
              GestureDetector(
                child: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                onTap: () => setState(() => _isObscure = !_isObscure),
              ),
          hintText: widget.hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color.fromRGBO(232, 232, 232, 1), width: 1.5),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
}
