import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ImagePicker extends HookWidget {
  const ImagePicker({
    super.key,
    required this.label,
    required this.selectedBackgroundColor,
    required this.onTap,
  });
  final String label;
  final ValueNotifier<Color?> selectedBackgroundColor;
  final void Function(Color) onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColors = <Color>[
      // 明るい色
      const Color(0xFF8CC251), // pistachio
      const Color(0xFFCCE5FF), // light blue
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
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(label, style: const TextStyle(fontSize: 16)),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: backgroundColors.length,
          itemBuilder: (context, index) {
            final color = backgroundColors[index];
            return GestureDetector(
              onTap: () => onTap(color),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: selectedBackgroundColor.value == color
                        ? Colors.blueAccent
                        : Colors.transparent,
                    width: 3,
                  ),
                  color: color,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
