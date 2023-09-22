import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/domain/entities/item.dart';

class AddItemDialog extends HookConsumerWidget {
  const AddItemDialog({super.key, required this.item});

  static void show(BuildContext context, Item item) {
    // ignore: inference_failure_on_function_invocation
    showDialog(
      context: context,
      builder: (context) => AddItemDialog(item: item),
    );
  }

  final Item item;
  bool get isUpdating => item.id != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController(text: item.title);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'タイトル'),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isUpdating
                      ? Colors.green
                      : Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  isUpdating
                      ? itemListNotifier.updateItem(
                          updatedItem: item.copyWith(
                            title: textController.text.trim(),
                          ),
                        )
                      : itemListNotifier.addItem(
                          title: textController.text.trim(),
                        );
                  Navigator.of(context).pop();
                },
                child: Text(isUpdating ? '更新' : '追加'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
