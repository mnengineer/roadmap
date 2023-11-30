import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/constants/colors.dart';
import 'package:roadmap/core/di/providers.dart';

class FilterTag extends HookConsumerWidget {
  const FilterTag({super.key, required this.title, required this.onTap});
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTag = ref.watch(selectedTagProvider);
    final isSelected = selectedTag == title;
    return GestureDetector(
      onTap: () {
        ref.read(selectedTagProvider.notifier).state = title;
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Chip(
            label: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.grey[100] : Colors.grey[900],
              ),
            ),
            avatar:
                isSelected ? const Icon(Icons.check, color: tWhiteColor) : null,
            backgroundColor: isSelected ? Colors.grey[900] : Colors.grey[100],
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: isSelected ? Colors.grey : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
