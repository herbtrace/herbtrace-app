import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:herbtrace_app/utils/snackbar_utils.dart';

class HapticUtils {
  /// Light haptic feedback for subtle interactions
  static void lightImpact() {
    HapticFeedback.lightImpact();
  }

  /// Medium haptic feedback for standard interactions
  static void mediumImpact() {
    HapticFeedback.mediumImpact();
  }

  /// Heavy haptic feedback for important interactions
  static void heavyImpact() {
    HapticFeedback.heavyImpact();
  }

  /// Selection changed feedback
  static void selectionClick() {
    HapticFeedback.selectionClick();
  }

  /// Vibration pattern for success actions
  static void successFeedback() {
    HapticFeedback.lightImpact();
  }

  /// Show success message with haptic feedback
  static void showSuccessWithFeedback(BuildContext context, String message) {
    successFeedback();
    SnackBarUtil.showSuccess(context, message);
  }

  /// Show error message with haptic feedback
  static void showErrorWithFeedback(BuildContext context, String message) {
    heavyImpact();
    SnackBarUtil.showError(context, message);
  }
}
