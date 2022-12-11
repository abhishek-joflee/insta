import 'package:flutter/material.dart'
    show Colors, TextStyle, VoidCallback, immutable, TextDecoration;

import 'link_text.dart';

@immutable
class BaseText {
  const BaseText({
    required this.text,
    this.style,
  });

  factory BaseText.plain({
    required String text,
    TextStyle? style = const TextStyle(),
  }) =>
      BaseText(
        text: text,
        style: style,
      );

  factory BaseText.link({
    required String text,
    required VoidCallback onTap,
    TextStyle? style = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  }) =>
      LinkText(
        text: text,
        onTap: onTap,
        style: style,
      );

  final String text;
  final TextStyle? style;
}
