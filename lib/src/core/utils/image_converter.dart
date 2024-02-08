import 'dart:ui' as ui;

import 'package:flutter/services.dart';

/// Loads an image from the asset bundle, resizes it to the specified dimensions,
/// and converts it to a Uint8List.
///
/// This function loads the image specified by [imagePath] from the asset bundle.
/// It then decodes the image data to a ui.Image, resizes the image to the dimensions
/// specified by [width] and [height], and finally converts the resized ui.Image
/// to a Uint8List in PNG format.
///
/// Parameters:
///   - [imagePath]: The path to the image asset in the asset bundle.
///   - [width]: The desired width of the resized image. Defaults to 120 pixels.
///   - [height]: The desired height of the resized image. Defaults to 120 pixels.
///
/// Returns:
///   A Future that resolves to a Uint8List representing the resized and converted image.
///
/// Example:
/// ```dart
/// Uint8List imageBytes = await convertImageToUint8List('assets/image.png', width: 200, height: 200);
/// ```
Future<Uint8List> convertImageToUint8List(String imagePath, {int width = 120, int height = 120}) async {
  // Load the image from the asset bundle.
  final ByteData data = await rootBundle.load(imagePath);
  final Uint8List bytes = data.buffer.asUint8List();

  // Decode the image data to a ui.Image.
  final ui.Codec codec = await ui.instantiateImageCodec(bytes);
  final ui.FrameInfo frameInfo = await codec.getNextFrame();
  ui.Image image = frameInfo.image;

  // Resize the image.
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final ui.Canvas canvas = ui.Canvas(recorder);
  final ui.Size size = ui.Size(width.toDouble(), height.toDouble());
  final ui.Paint paint = ui.Paint();
  canvas.drawImageRect(
    image,
    ui.Rect.fromLTRB(0, 0, image.width.toDouble(), image.height.toDouble()),
    ui.Rect.fromLTRB(0, 0, size.width, size.height),
    paint,
  );
  image = await recorder.endRecording().toImage(width, height);

  // Convert the resized ui.Image to Uint8List.
  final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}
