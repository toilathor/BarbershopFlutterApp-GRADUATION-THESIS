import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:http/http.dart' as http;

class AuthAPI {
  var client = http.Client();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<bool> checkUserExist(String phoneNumber) async {
    http.Response response = await client.get(
      Uri.parse('$localHost/auth/check-user/$phoneNumber'),
    );

    try {
      var data = jsonDecode(response.body);
      return data['data'];
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<Map<dynamic, dynamic>?> loginWithPhoneNumber(
      String phoneNumber, String password) async {
    http.Response response = await client.post(
      Uri.parse('$localHost/auth/login-phone-number'),
      body: {
        'phone_number': phoneNumber,
        'password': password,
      },
    );

    try {
      var data = jsonDecode(response.body);

      return {data['user']: data['token']};
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<Map<dynamic, dynamic>?> loginWithSocials(
      Map<String, String> account, TypeSocial typeSocial) async {
    var url = '$localHost/auth/login-socials/${typeSocial.name}';

    http.Response response = await client.post(
      Uri.parse(url),
      body: {
        'name': account['name'],
        'phone_number': account['phone_number'],
        'email': account['email'],
        'provider_id': account['provider_id'],
      },
    );
    try {
      var data = jsonDecode(response.body);

      return {data['user']: data['token']};
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<Map<dynamic, dynamic>?> register(
      String phoneNumber, String name, String password) async {
    http.Response response = await client.post(
      Uri.parse('$localHost/auth/register'),
      body: {
        'phone_number': phoneNumber,
        'name': name,
        'password': password,
        'password_confirmation': password
      },
    );

    try {
      var data = jsonDecode(response.body);

      return {data['user']: data['token']};
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  verifyPhoneNumber({
    required String phoneNumber,
    required void Function(PhoneAuthCredential phoneAuthCredential)
        verificationCompleted,
    required void Function(FirebaseAuthException error) verificationFailed,
    required void Function(String verificationId, int? forceResendingToken)
        codeSent,
    required void Function(String verificationId) codeAutoRetrievalTimeout,
    Duration timeout = const Duration(seconds: 30),
    int? forceResendingToken,
  }) async {
    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: timeout,
        forceResendingToken: forceResendingToken);
  }

  forgotPassword({String? phoneNumber, String? email}) async {
    // if (email != null) {
    //   await firebaseAuth.sendPasswordResetEmail(email: email);
    // }

    firebaseAuth.currentUser?.updateEmail("Lequangtho2000lqtho2@gmail.com");
    debugPrint(firebaseAuth.currentUser?.email);
  }

  resetFirebaseAuth() {
    firebaseAuth = FirebaseAuth.instance;
  }

  Future<bool> resetPassword(String phoneNumber, String password) async {
    http.Response response =
        await client.post(Uri.parse('$localHost/auth/reset-password/'), body: {
      "password": password,
      "phone_number": phoneNumber,
    });

    try {
      var data = jsonDecode(response.body);
      return data['data'];
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

enum TypeSocial { none, facebook, google, zalo }
