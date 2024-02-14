import 'package:flutter/material.dart';
import 'package:jalda/src/core/utils/extensions/num_extensions.dart';

/// Default button
/// Elevated button, that commonly used
class AppButton extends StatelessWidget {
  /// Creates an ElevatedButton.If none of the values is used, Its expands to the all width, with vertical padding 10, and borderRadius 16.
  const AppButton({
    super.key,
    this.height,
    this.child,
    this.width,
    this.onPressed,
    this.borderRadius = 16,
    this.padding,
    this.margin,
    this.color,
    this.text,
    this.textColor,
    this.border = false,
    this.borderColor,
  });

  /// Child of the button, (can be icon, row and etc.)
  final Widget? child;

  /// Width
  final double? width;

  /// Height
  final double? height;

  /// Internal margin
  final EdgeInsetsGeometry? padding;

  /// Outer margin
  final EdgeInsetsGeometry? margin;

  /// Rounding
  final double borderRadius;

  /// Color
  final Color? color;

  /// Function of the button
  final GestureTapCallback? onPressed;

  /// Used when child is not needed.
  final String? text;

  /// Text color
  final Color? textColor;

  ///Borders of the button, false == noBorder;
  final bool? border;

  ///Color of the border
  final Color? borderColor;

  @override
  Widget build(BuildContext context) => Container(
        height: height,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: border! ? Border.fromBorderSide(BorderSide(width: 2, color: borderColor!)) : null,
        ),
        child: ElevatedButton(
          onPressed: () => onPressed?.call(),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: padding ?? 10.vp,
            backgroundColor: color ?? Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
          ),
          child: text != null
              ? Center(
                  child: Text(
                    text!,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: textColor ?? Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                )
              : child,
        ),
      );
}
