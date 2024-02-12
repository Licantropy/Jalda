import 'dart:ui' as ui;

import 'package:flutter/services.dart';

/// Loads an image from the asset bundle and converts it to a Uint8List after resizing.
///
/// This function takes an image path as input and optionally allows specifying
/// the width and height to resize the image. It first loads the image from the asset
/// bundle into a ByteData object. Then, it uses the dart:ui library to decode the image
/// and resize it to the specified dimensions.
///
/// The function handles resizing by using instantiateImageCodec, which decodes the
/// image bytes and resizes the image according to the target width and height. After
/// decoding and resizing, it converts the image to a PNG format ByteData and then
/// to Uint8List for easy use with Flutter widgets.
///
/// Throws an exception if the image cannot be resized (e.g., if the resizing operation
/// returns null).
///
/// Example usage:
/// ```dart
/// Uint8List iconBytes = await convertImageToUint8List('assets/icon.png', width: 50, height: 50);
/// ```
///
/// Parameters:
///   - imagePath (String): The path to the image asset.
///   - width (int): Optional. The target width to resize the image to. Defaults to 100.
///   - height (int): Optional. The target height to resize the image to. Defaults to 100.
///
/// Returns:
///   - A future Uint8List containing the resized image data.
Future<Uint8List> convertImageToUint8List(String imagePath, {int width = 100, int height = 100}) async {
  final ByteData data = await rootBundle.load(imagePath);
  final Uint8List bytes = data.buffer.asUint8List();
  final ui.Codec codec = await ui.instantiateImageCodec(bytes, targetWidth: width, targetHeight: height);
  final ui.FrameInfo fi = await codec.getNextFrame();
  final ByteData? resizedData = await fi.image.toByteData(format: ui.ImageByteFormat.png);

  if (resizedData == null) {
    throw Exception('Failed to resize image');
  }

  return resizedData.buffer.asUint8List();
}
