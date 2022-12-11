import 'package:flutter/material.dart' show Color;

import 'remove_all.dart';

// convert 0x?????? or #?????? to color
extension AsHtmlColorToColor on String {
  Color htmlColorToColor() => Color(
        int.parse(
          removeAll(['0x', '#']).padLeft(8, 'ff'),
          radix: 16,
        ),
      );
}
