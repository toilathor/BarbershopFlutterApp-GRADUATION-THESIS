import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:http/http.dart' as http;

class AuthAPI {
  var client = http.Client();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<bool> checkUserExisis(String phoneNumber) async {
    http.Response response = await client.get(
      Uri.parse('$localhost/auth/check-user/$phoneNumber'),
    );

    try {
      var data = jsonDecode(response.body);
      return data['data'];
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  verifyPhoneNumber({
    required String phoneNumber,
    required void Function(PhoneAuthCredential phoneAuthCredential) verificationCompleted,
    required void Function(FirebaseAuthException error) verificationFailed,
    required void Function(String verificationId, int? forceResendingToken) codeSent,
    required void Function(String verificationId) codeAutoRetrievalTimeout,
    Duration timeout = const Duration(seconds: 30),
    int? forceResendingToken,
  }) async {
    firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      timeout: timeout,
      forceResendingToken: forceResendingToken
    );
  }
}
