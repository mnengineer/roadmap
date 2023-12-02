import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:roadmap/core/constants/colors.dart';

class DatePicker extends HookWidget {
  const DatePicker({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.errorText,
  });
  final String label;
  final ValueNotifier<DateTime?> selectedDate;
  final ValueNotifier<String?> errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              errorText.value = null;
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: errorText.value != null
                  ? Border.all(color: Colors.red)
                  : Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              selectedDate.value == null
                  ? label
                  : DateFormat('yyyy-MM-dd').format(selectedDate.value!),
              style: const TextStyle(fontSize: 16, color: tWhiteColor),
            ),
          ),
        ),
        if (errorText.value != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 12),
            child: Text(
              errorText.value!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
