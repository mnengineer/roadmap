import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ImagePickerWidget extends HookWidget {
  const ImagePickerWidget({
    super.key,
    required this.label,
    required this.selectedImagePath,
    required this.onImageTap,
    this.isRequired = false,
  });
  final String label;
  final ValueNotifier<String?> selectedImagePath;
  final void Function(String) onImageTap;
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
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List<Widget>.generate(20, (index) {
            final imagePath = 'assets/images/dashboard/${index + 1}.jpeg';
            return GestureDetector(
              onTap: () => onImageTap(imagePath),
              child: Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: selectedImagePath.value == imagePath
                        ? Colors.blue
                        : Colors.grey,
                    width: 2,
                  ),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
