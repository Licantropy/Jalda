import 'package:flutter/material.dart';

/// Default textField that commonly used
class AppTextField extends StatelessWidget {
  /// TextField controller
  final TextEditingController controller;

  /// Hint
  final String? hintText;

  /// Icon at the beginning of the te
  final Widget? prefixIcon;

  /// Icon in the end of the field
  final Widget? suffixIcon;

  /// Max length of the input symbols
  final int? maxLength;

  /// Creates a TextField. Controller is required named parameter.
  const AppTextField({
    required this.controller,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLength,
    super.key,
  });

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        maxLength: maxLength,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color.fromRGBO(232, 232, 232, 1), width: 1.5)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
}
