import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final snackbarProvider = Provider((ref) => Snackbar());

class Snackbar {
  void successSnackBar(
    BuildContext context, {
    required String title,
    String? message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login successful!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
