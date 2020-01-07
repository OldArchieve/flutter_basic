import 'dart:async';
import '../models/model.dart';
import 'package:flutter/services.dart';

class Auth {
  static Future<String> signIn(String email, String password) async {
    return await null;
  }

  static Future<String> signInWithFacebook(String accessToken) async {
    return await null;
  }

  static Future<String> signUp(String email, String password) async {
    return await null;
  }

  static Future<void> signOut() async {
    return await null;
  }

  static Future<User> getCurrentFirebaseUser() async {
    return await null;
  }

  static void addUser(User user) async {
    checkUserExist(user.id).then((value) {
      if (!value) {
        print("user ${user.firstName} ${user.email} added");
      } else {
        print("user ${user.firstName} ${user.email} exists");
      }
    });
  }

  static Future<bool> checkUserExist(int userID) async {
    bool exists = false;
    try {
      return exists;
    } catch (e) {
      return false;
    }
  }

  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this e-mail not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'Email address is already taken.';
          break;
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }
}
