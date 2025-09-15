import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

class QRService {
  static final QRService _instance = QRService._internal();

  factory QRService() => _instance;

  QRService._internal();

  QrImage generateQRCode({
    required String data,
    double size = 200,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return QrImage(
      QrCode(size.toInt(), size.toInt()),
      // TODO: Uncomment when qr_flutter is added
      // version: QrVersions.auto,
      // size: size,
      // backgroundColor: backgroundColor ?? Colors.white,
      // foregroundColor: foregroundColor ?? Colors.black,
    );
  }

  Future<String> generateQRString(Map<String, dynamic> data) async {
    // Convert the map to a JSON string
    return Uri.encodeComponent(data.toString());
  }
}
