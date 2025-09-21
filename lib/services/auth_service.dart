import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:flutter/material.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/consts/sharedpreferences_consts.dart';
import 'package:herbtrace_app/models/common/profile_type.dart';
import 'package:herbtrace_app/providers/common/profile_provider.dart';
import 'package:herbtrace_app/services/auth/login_service.dart';
import 'package:herbtrace_app/services/profile_check_service.dart';
import 'package:herbtrace_app/utils/user_preferences.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;

  late final ProfileCheckService _profileCheckService;
  late final LoginService _loginService;
  Timer? _otpTimer;
  String? _currentOTP;

  Future<void> init() async {
    _profileCheckService = ProfileCheckService();
    _loginService = LoginService();
  }

  AuthService._internal();

  String _generateOTP() {
    final random = Random();
    final otp = (100000 + random.nextInt(900000)).toString();
    _currentOTP = otp;
    debugPrint('Generated OTP: $otp');
    // Copy OTP to clipboard

    Clipboard.setData(ClipboardData(text: otp));
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

    final exists = await _profileCheckService.checkIfProfileExists(phone);
    if (!exists) {
      throw Exception('No profile found with this phone number');
    }

    await Future.delayed(const Duration(seconds: 1));
    final otp = _generateOTP();

    return {'success': true, 'message': 'OTP sent successfully', 'otp': otp};
  }

  Future<Map<String, dynamic>> verifyEmail(String email) async {
    if (!isValidEmail(email)) {
      throw Exception('Invalid email address');
    }

    final exists = await _profileCheckService.checkIfProfileExists(email);
    if (!exists) {
      throw Exception('No profile found with this email address');
    }

    await Future.delayed(const Duration(seconds: 1));
    final otp = _generateOTP();

    return {'success': true, 'message': 'OTP sent successfully', 'otp': otp};
  }

  bool verifyOTP(String enteredOTP) {
    if (_currentOTP == null) return false;
    return _currentOTP == enteredOTP;
  }

  Future<void> completeLogin(String profileId, WidgetRef ref) async {
    final loginData = await _loginService.loginUser(profileId);
    ref.read(profileTypeProvider.notifier).state = ProfileType.fromString(
      loginData['role'] as String,
    );
    print("set profileId $profileId and role ${loginData['role']}");
    ref.read(profileTypeProvider.notifier).state = ProfileType.fromString(
      loginData['role'] ?? '',
    );
    await Future.wait([
      UserPreferences.setUserRole(loginData['role']),
      UserPreferences.setProfileId(profileId),
      UserPreferences.setProfileData(loginData['data'] as Map<String, dynamic>),
    ]);
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
