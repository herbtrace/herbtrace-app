import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  String? confirmText,
  String? cancelText,
  bool isDestructive = false,
}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelText ?? 'Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(
            foregroundColor: isDestructive ? Colors.red : null,
          ),
          child: Text(confirmText ?? 'Confirm'),
        ),
      ],
    ),
  );
}
