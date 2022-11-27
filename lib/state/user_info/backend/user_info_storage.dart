import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../../constants/firebase_collection_names.dart';
import '../../constants/firebase_field_names.dart';
import '../../posts/typedefs/user_id.dart';
import '../models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) async {
    try {
      // first check if we have this user info from before
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.users)
          .where(FirebaseFieldNames.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        // update the existing user info
        final payload = UserInfoPayload(
          displayName: displayName ?? '',
          email: email ?? '',
        );
        await userInfo.docs.first.reference.update(payload);
        return true;
      }

      // add this user info
      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.users)
          .add(payload);
      return true;
    } catch (e) {
      log(':error', error: e);
      return false;
    }
  }
}
