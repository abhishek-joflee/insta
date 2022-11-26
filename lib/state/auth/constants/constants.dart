import 'package:flutter/foundation.dart' show immutable;

@immutable
class AuthConstants {
  const AuthConstants._();

  static const accountExistsWithDifferentCredentials =
      'account-exists-with-different-credentials';
  static const googleCom = 'google.com';
  static const emailScope = 'email';
}
