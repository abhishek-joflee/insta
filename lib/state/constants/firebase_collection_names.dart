import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseCollectionNames {
  const FirebaseCollectionNames._();

  static const users = 'users';
  static const posts = 'posts';
  static const likes = 'likes';
  static const comments = 'comments';
  static const images = 'images';
  static const thumbnails = 'thumbnails';
}
