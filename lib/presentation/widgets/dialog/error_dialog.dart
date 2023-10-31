import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final errorDialogProvider = Provider((ref) => ErrorDialog());

class ErrorDialog {
  void showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
