import 'dart:developer' as dev;
import 'package:flutter/material.dart';

class SnackBarUtil {
  static const _defaultDuration = Duration(seconds: 4);
  static const _snackBarTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  static void _clearSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static void _logMessage(String message, {String level = 'info'}) {
    switch (level) {
      case 'error':
        dev.log(message, level: 1000, name: 'ERROR');
        break;
      case 'warning':
        dev.log(message, level: 900, name: 'WARNING');
        break;
      case 'info':
        dev.log(message, level: 800, name: 'INFO');
        break;
      default:
        dev.log(message, name: 'APP');
    }
  }

  static void showSuccess(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    _show(
      context,
      message,
      backgroundColor: Colors.green[700]!,
      icon: Icons.check_circle,
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    _logMessage(message, level: 'error');
    _show(
      context,
      message,
      backgroundColor: Colors.red[700]!,
      icon: Icons.error,
    );
  }

  static void showInfo(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    _logMessage(message, level: 'info');
    _show(
      context,
      message,
      backgroundColor: Colors.blue[700]!,
      icon: Icons.info,
    );
  }

  static void showWarning(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    _logMessage(message, level: 'warning');
    _show(
      context,
      message,
      backgroundColor: Colors.orange[700]!,
      icon: Icons.warning,
    );
  }

  static void _show(
    BuildContext context,
    String message, {
    required Color backgroundColor,
    required IconData icon,
    Duration? duration,
  }) {
    _clearSnackBar(context);

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(child: Text(message, style: _snackBarTextStyle)),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: duration ?? _defaultDuration,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: () => _clearSnackBar(context),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
