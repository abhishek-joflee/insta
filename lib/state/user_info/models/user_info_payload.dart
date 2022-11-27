import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;

import '../../constants/firebase_field_names.dart';
import '../../posts/typedefs/user_id.dart';

@immutable
class UserInfoPayload extends MapView<String, dynamic> {
  UserInfoPayload({
    UserId? userId,
    String? displayName,
    String? email,
  }) : super(
          {
            if (userId != null) FirebaseFieldNames.userId: userId,
            if (displayName != null)
              FirebaseFieldNames.displayName: displayName,
            if (email != null) FirebaseFieldNames.email: email,
          },
        );
}
