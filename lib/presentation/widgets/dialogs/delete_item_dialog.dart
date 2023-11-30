import 'package:flutter/material.dart';
import 'package:roadmap/core/constants/colors.dart';

class DeleteItemDialog extends StatelessWidget {
  const DeleteItemDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onDelete,
    required this.onCancel,
  });

  final String title;
  final String content;
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: const TextStyle(color: tDarkColor)),
      content: Text(content, style: const TextStyle(color: tDarkColor)),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onDelete,
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
