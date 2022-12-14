// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD-me_Fccz1ekrgoJh9wh99-fAcZB1z0aw',
    appId: '1:581897274150:web:231b8b239ecc98312ab7e7',
    messagingSenderId: '581897274150',
    projectId: 'joflee-insta-clone',
    authDomain: 'joflee-insta-clone.firebaseapp.com',
    storageBucket: 'joflee-insta-clone.appspot.com',
    measurementId: 'G-ZQRRR4SB18',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDdn-88Rlf-ntfPxcUgoLrtvDK5MGhHDO8',
    appId: '1:581897274150:android:2ff7842b9261f6f62ab7e7',
    messagingSenderId: '581897274150',
    projectId: 'joflee-insta-clone',
    storageBucket: 'joflee-insta-clone.appspot.com',
  );
}
