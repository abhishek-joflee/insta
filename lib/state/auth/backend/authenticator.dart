import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../posts/typedefs/user_id.dart';
import '../constants/constants.dart';
import '../model/auth_result.dart';
import 'github_login_helper.dart';

@immutable
class Authenticator {
  const Authenticator();

  User? get _user => FirebaseAuth.instance.currentUser;
  UserId? get userId => _user?.uid;
  bool get isLoggedIn => userId != null;
  String? get displayName => _user?.displayName;
  String? get email => _user?.email;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  Future<AuthResult> signInWithGithub() async {
    final token = await GithubLoginHelper.instance.login();
    if (token == null) {
      //? user has aborted the login process
      return AuthResult.aborted;
    }

    final oAuthCred = GithubAuthProvider.credential(token);
    try {
      await FirebaseAuth.instance.signInWithCredential(oAuthCred);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final cred = e.credential;
      if (e.code == AuthConstants.accountExistsWithDifferentCredential &&
          email != null &&
          cred != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        if (providers.contains(AuthConstants.googleCom)) {
          await signInWithGoogle();
          //? link the credentials
          await FirebaseAuth.instance.currentUser?.linkWithCredential(cred);
          return AuthResult.success;
        }
      }
      log(':error', error: e);
      return AuthResult.failure;
    }
  }

  Future<AuthResult> signInWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.token;

    if (token == null) {
      //? user has aborted the login process
      return AuthResult.aborted;
    }
    final oAuthCred = FacebookAuthProvider.credential(token);

    try {
      await FirebaseAuth.instance.signInWithCredential(oAuthCred);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final cred = e.credential;
      if (e.code == AuthConstants.accountExistsWithDifferentCredential &&
          email != null &&
          cred != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        if (providers.contains(AuthConstants.googleCom)) {
          await signInWithGoogle();

          //? link the credentials
          await FirebaseAuth.instance.currentUser?.linkWithCredential(cred);
        }
        return AuthResult.success;
      }
      log(':error', error: e);
      return AuthResult.failure;
    }
  }

  Future<AuthResult> signInWithGoogle() async {
    final googleUser = await GoogleSignIn(
      scopes: [AuthConstants.emailScope],
    ).signIn();

    if (googleUser == null) {
      //? user has aborted the login process
      return AuthResult.aborted;
    }

    final googleAuth = await googleUser.authentication;

    final oAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
      return AuthResult.success;
    } catch (e) {
      log(':error', error: e);
      return AuthResult.failure;
    }
  }
}
