import 'package:flutter/foundation.dart' show VoidCallback, immutable;

import 'base_text.dart';

@immutable
class LinkText extends BaseText {
  const LinkText({
    required this.onTap,
    required super.text,
    super.style,
  });

  final VoidCallback onTap;
}
