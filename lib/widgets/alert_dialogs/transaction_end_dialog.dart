import 'package:flutter/material.dart';
import 'package:herbtrace_app/generated/app_localizations.dart';
import 'package:herbtrace_app/utils/crop_localization_utils.dart';
import '../../utils/datetime_utils.dart';

class TransactionEndDialog extends StatefulWidget {
  final DateTime startTime;
  final DateTime endTime;
  final String cropName;
  final double quantity;
  final Future<Map<String, dynamic>> Function() onConfirm;
  final VoidCallback onCancel;

  const TransactionEndDialog({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.cropName,
    required this.quantity,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<TransactionEndDialog> createState() => _TransactionEndDialogState();
}

class _TransactionEndDialogState extends State<TransactionEndDialog> {
  bool _isLoading = false;
  String? _error;

  Future<void> _handleConfirm() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await widget.onConfirm();
      if (mounted) {
        Navigator.of(context).pop(result);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final duration = DateTimeUtils.getDurationString(
      widget.startTime,
      widget.endTime,
    );
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async => !_isLoading,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isLoading) ...[
                const CircularProgressIndicator(),
                const SizedBox(height: 24),
                const Text('Processing...'),
              ] else ...[
                Icon(
                  Icons.timer_outlined,
                  size: 48,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  AppLocalizations.of(context)!.endTransaction,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.grass),
                  subtitle: Text(AppLocalizations.of(context)!.cropLabel),
                  title: Text(
                    CropLocalizationUtils.getLocalizedCropName(
                      context,
                      widget.cropName,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.timer),
                  subtitle: Text(AppLocalizations.of(context)!.durationLabel),
                  title: Text(
                    AppLocalizations.of(context)!.durationFormat(
                      widget.endTime.difference(widget.startTime).inHours,
                      widget.endTime.difference(widget.startTime).inMinutes %
                          60,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.scale),
                  subtitle: Text(AppLocalizations.of(context)!.quantityLabel),
                  title: Text('${widget.quantity} kg'),
                ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      _error!,
                      style: TextStyle(color: theme.colorScheme.error),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _isLoading ? null : widget.onCancel,
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _handleConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                      child: Text(AppLocalizations.of(context)!.confirm),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
