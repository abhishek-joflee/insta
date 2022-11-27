import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../posts/typedefs/user_id.dart';
import '../../user_info/backend/user_info_storage.dart';
import '../backend/authenticator.dart';
import '../model/auth_result.dart';
import '../model/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  Future<void> logOut() async {
    state = state.copyWith(isLoading: true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> _saveUserInfo(UserId userId) async =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );

  Future<void> loginWithGoogle() async {
    state = state.copyWith(isLoading: true);
    final result = await _authenticator.signInWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await _saveUserInfo(userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> loginWithFacebook() async {
    state = state.copyWith(isLoading: true);
    final result = await _authenticator.signInWithFacebook();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await _saveUserInfo(userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> loginWithGithub() async {
    state = state.copyWith(isLoading: true);
    final result = await _authenticator.signInWithGithub();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await _saveUserInfo(userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }
}
