import 'package:flutter/foundation.dart' show immutable;

@immutable
class AuthConstants {
  const AuthConstants._();

  static const accountExistsWithDifferentCredential =
      'account-exists-with-different-credential';
  static const googleCom = 'google.com';
  static const emailScope = 'email';
}
