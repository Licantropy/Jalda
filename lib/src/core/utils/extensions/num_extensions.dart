import 'package:flutter/material.dart';

/// Extends the [num] class with convenient methods for creating Flutter layout
/// and styling elements. This extension simplifies the process of defining
/// common layout properties by allowing direct conversion of numerical values
/// into [SizedBox], [BorderRadius], and [EdgeInsets] objects.
///
/// By using these extensions, you can write more concise and readable Flutter
/// code. For example, instead of writing `EdgeInsets.all(8.0)`, you can simply
/// use `8.p`. This makes your layout definitions more intuitive and cleaner.
///
/// Examples:
///   - `10.w` creates a [SizedBox] with a width of 10.
///   - `10.h` creates a [SizedBox] with a height of 10.
///   - `10.r` creates a [BorderRadius] with a circular radius of 10.
///   - `10.hp` creates an [EdgeInsets] with horizontal padding of 10.
///   - `10.vp` creates an [EdgeInsets] with vertical padding of 10.
///   - `10.p` creates an [EdgeInsets] with padding on all sides of 10.
///
extension NumExtension on num {

  /// Extension to create a [SizedBox] with a specific width.
  ///
  /// Example:
  ///   - `10.w` creates a [SizedBox] with a width of 10.
  SizedBox get w => SizedBox(width: toDouble());

  /// Extension to create a [SizedBox] with a specific height.
  ///
  /// Example:
  ///   - `10.h` creates a [SizedBox] with a height of 10.
  SizedBox get h => SizedBox(height: toDouble());

  /// Extension to create a [BorderRadius] with a circular radius.
  ///
  /// Example:
  ///   - `10.r` creates a [BorderRadius] with a circular radius of 10.
  BorderRadius get r => BorderRadius.circular(toDouble());

  /// Extension to create [EdgeInsets] with horizontal padding.
  ///
  /// Example:
  ///   - `10.hp` creates an [EdgeInsets] with horizontal padding of 10.
  EdgeInsets get hp => EdgeInsets.symmetric(horizontal: toDouble());

  /// Extension to create [EdgeInsets] with vertical padding.
  ///
  /// Example:
  ///   - `10.vp` creates an [EdgeInsets] with vertical padding of 10.
  EdgeInsets get vp => EdgeInsets.symmetric(vertical: toDouble());

  /// Extension to create [EdgeInsets] with padding on all sides.
  ///
  /// Example:
  ///   - `10.p` creates an [EdgeInsets] with padding on all sides of 10.
  EdgeInsets get p => EdgeInsets.all(toDouble());

}
