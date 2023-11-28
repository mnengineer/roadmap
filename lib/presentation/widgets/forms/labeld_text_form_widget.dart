import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LabeledTextFormWidget extends HookWidget {
  const LabeledTextFormWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isRequired = false,
  });
  final String label;
  final String hint;
  final bool isRequired;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isRequired ? Colors.red : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isRequired ? '必須' : '任意',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}
