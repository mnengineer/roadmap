import 'package:flutter/material.dart';
import 'package:roadmap/core/constants/colors.dart';

class LabeledTextFormWidget extends StatelessWidget {
  const LabeledTextFormWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.maxLines,
    required this.controller,
    required this.validator,
  });
  final String label;
  final String hint;
  final IconData icon;
  final int maxLines;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          style: const TextStyle(
            color: tWhiteColor,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: tWhiteColor,
            ),
            labelText: label,
            labelStyle: const TextStyle(
              color: tWhiteColor,
            ),
            floatingLabelStyle: const TextStyle(
              color: tWhiteColor,
            ),
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: tWhiteColor),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: tWhiteColor),
            ),
          ),
        ),
      ],
    );
  }
}
