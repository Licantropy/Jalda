import 'dart:ui';

import 'package:flutter/material.dart';

class BlurDialogBackgroundWidget extends StatelessWidget {
  final Widget child;

  const BlurDialogBackgroundWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: [BackdropFilter(filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8), child: const SizedBox.expand()), child],
      );
}
