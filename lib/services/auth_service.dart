import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart' show debugPrint;

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  String? _currentOTP;
  Timer? _otpTimer;

  String _generateOTP() {
    final random = Random();
    final otp = (100000 + random.nextInt(900000)).toString();
    _currentOTP = otp;
    debugPrint('Generated OTP: $otp');
    return otp;
  }

  bool isValidPhoneNumber(String phone) {
    final RegExp phoneRegex = RegExp(r'^[6-9]\d{9}$');
    return phoneRegex.hasMatch(phone);
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegex.hasMatch(email);
  }

  Future<Map<String, dynamic>> verifyPhone(String phone) async {
    if (!isValidPhoneNumber(phone)) {
      throw Exception('Invalid phone number');
    }

    await Future.delayed(const Duration(seconds: 1));
    final otp = _generateOTP();

    return {'success': true, 'message': 'OTP sent successfully', 'otp': otp};
  }

  Future<Map<String, dynamic>> verifyEmail(String email) async {
    if (!isValidEmail(email)) {
      throw Exception('Invalid email address');
    }

    await Future.delayed(const Duration(seconds: 1));
    final otp = _generateOTP();

    return {'success': true, 'message': 'OTP sent successfully', 'otp': otp};
  }

  bool verifyOTP(String enteredOTP) {
    if (_currentOTP == null) return false;
    return _currentOTP == enteredOTP;
  }

  void startOTPTimer(Function() onTimerComplete) {
    _otpTimer?.cancel();
    _otpTimer = Timer(const Duration(minutes: 2), () {
      _currentOTP = null;
      onTimerComplete();
    });
  }

  void dispose() {
    _otpTimer?.cancel();
    _currentOTP = null;
  }
}
