import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class DatePicker extends HookWidget {
  const DatePicker({
    super.key,
    required this.label,
    required this.hint,
    required this.selectedDate,
    this.isRequired = false,
  });
  final String label;
  final String hint;
  final ValueNotifier<DateTime?> selectedDate;
  final bool isRequired;

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
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: selectedDate.value ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              selectedDate.value = date;
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              selectedDate.value == null
                  ? hint
                  : DateFormat('yyyy-MM-dd').format(selectedDate.value!),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
