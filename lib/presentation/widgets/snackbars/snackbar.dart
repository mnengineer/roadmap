import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final snackbarProvider = Provider((ref) => Snackbar());

class Snackbar {
  void successSnackBar(
    BuildContext context, {
    required String title,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
