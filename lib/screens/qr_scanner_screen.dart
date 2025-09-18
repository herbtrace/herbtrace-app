import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:herbtrace_app/config/theme.dart';
import 'package:herbtrace_app/services/transaction_service.dart';
import 'package:herbtrace_app/utils/user_preferences.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  MobileScannerController? _controller;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _handleScannedData(String rawData) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    try {
      final qrData = jsonDecode(rawData);

      await _controller?.stop();

      final currentProfileId = await UserPreferences.getProfileId();
      final currentUserRole = await UserPreferences.getUserRole();

      final Map<String, dynamic> transactionDetails = {};

      if (!mounted) return;

      final shouldTransfer = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Transfer'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Batch ID: ${qrData['batch_id']}'),
                const SizedBox(height: 8),
                Text('From: ${qrData['from_id']} (${qrData['from_role']})'),
                const SizedBox(height: 8),
                Text('To: $currentProfileId ($currentUserRole)'),
                const SizedBox(height: 16),
                const Text(
                  'Transaction Details:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  const JsonEncoder.withIndent(
                    '  ',
                  ).convert(transactionDetails),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Confirm Transfer'),
            ),
          ],
        ),
      );

      if (shouldTransfer == true) {
        final success = await TransactionService.transferBatchWithQRData(
          qrData: qrData,
          toId: currentProfileId,
          toRole: currentUserRole,
        );

        if (!mounted) return;

        if (success) {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Transfer Successful'),
              content: const Text(
                'The batch has been transferred successfully.',
              ),
              actions: [
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          throw Exception('Transfer failed');
        }
      } else {
        await _controller?.start();
      }
    } catch (e) {
      if (!mounted) return;
      print(e);
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to process QR code: ${e.toString()}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      await _controller?.start();
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: _controller?.torchState ?? ValueNotifier(false),
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off);
                  case TorchState.on:
                    return const Icon(Icons.flash_on);
                }
              },
            ),
            onPressed: () => _controller?.toggleTorch(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  _handleScannedData(barcode.rawValue ?? '');
                  break;
                }
              }
            },
          ),

          CustomPaint(
            painter: ScannerOverlayPainter(),
            child: const SizedBox.expand(),
          ),
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.fill;

    final scanArea = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * 0.8,
      height: size.width * 0.8,
    );

    final path = Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      Path()..addRect(scanArea),
    );

    canvas.drawPath(path, paint);

    final borderPaint = Paint()
      ..color = AppTheme.primaryGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawRect(scanArea, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
