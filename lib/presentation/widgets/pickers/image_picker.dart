import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ImagePicker extends HookWidget {
  const ImagePicker({
    super.key,
    required this.label,
    required this.selectedBackgroundColor,
    required this.onTap,
    this.isRequired = false,
  });
  final String label;
  final ValueNotifier<Color?> selectedBackgroundColor;
  final void Function(Color) onTap;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final backgroundColors = <Color>[
      // 明るい色
      const Color(0xFFFFF8E1), // pale yellow
      const Color(0xFFFFF3CD), // pale orange
      const Color(0xFFFFF0F0), // pale pink
      const Color(0xFFF5E6CC), // beige
      const Color(0xFFFFD6D6), // light pink
      const Color(0xFFD7F9E9), // pale green
      const Color(0xFFD4EDDA), // mint green
      const Color(0xFF8CC251), // pistachio
      const Color(0xFFCCE5FF), // light blue
      const Color(0xFFE6F9FF), // pale blue
      // 鮮やかな色
      const Color(0xFF07C0B0), // turquoise
      const Color(0xFF00D0B9), // medium turquoise
      const Color(0xFF0099FF), // blue ribbon
      const Color(0xFF446DC5), // medium blue
      const Color(0xFF4E598C), // liberty
      const Color(0xFF3FA34D), // jade green
      const Color(0xFF0079BF), // azure
      const Color(0xFFFF7100), // bright orange
      const Color(0xFFFF2D55), // radical red
      const Color(0xFFCC73E1), // bright lavender
      // 暗い色
      const Color(0xFF2E294E), // eggplant
      const Color(0xFFEC7505), // pumpkin
      const Color(0xFF333333), // mine shaft
      const Color(0xFF1E2023), // jet black
      const Color(0xFF000000), // black
      // グレイスケール
      const Color(0xFFE5E5E5), // light grey
    ];

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
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List<Widget>.generate(backgroundColors.length, (index) {
            return GestureDetector(
              onTap: () => onTap(backgroundColors[index]),
              child: Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        selectedBackgroundColor.value == backgroundColors[index]
                            ? Colors.blue
                            : Colors.grey,
                    width: 2,
                  ),
                  color: backgroundColors[index],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
