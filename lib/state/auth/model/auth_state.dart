import 'package:flutter/foundation.dart' show immutable;

import '../../posts/typedefs/user_id.dart';
import 'auth_result.dart';

@immutable
class AuthState {
  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
  });

  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null;

  final AuthResult? result;
  final bool isLoading;
  final UserId? userId;

  AuthState copyWith({
    AuthResult? result,
    bool? isLoading,
    UserId? userId,
  }) {
    return AuthState(
      result: result ?? this.result,
      isLoading: isLoading ?? this.isLoading,
      userId: userId ?? this.userId,
    );
  }

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (other.result == result &&
          other.isLoading == isLoading &&
          other.userId == userId);

  @override
  int get hashCode => result.hashCode ^ isLoading.hashCode ^ userId.hashCode;

  @override
  String toString() =>
      'AuthState(result: $result, isLoading: $isLoading, userId: $userId)';
}
