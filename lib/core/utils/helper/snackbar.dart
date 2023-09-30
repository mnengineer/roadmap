import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final snackbarProvider = Provider((ref) => SnackbarHelper());

class SnackbarHelper {
  void successSnackBar(
    BuildContext context, {
    required String title,
    String? message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title: $message'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // ... other snackbar functions
}
