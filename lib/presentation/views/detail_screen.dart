import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/domain/entities/item.dart';

class DetailScreen extends HookConsumerWidget {
  const DetailScreen({super.key, required this.item});

  final Item item;
  bool get isUpdating => item.id != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeTabViewModelProvider.notifier);
    final textController = useTextEditingController(text: item.title);

    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdating ? 'アイテムを更新' : 'アイテムを追加'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
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
                      ? viewModel.updateItem(
                          updatedItem: item.copyWith(
                            title: textController.text.trim(),
                          ),
                        )
                      : viewModel.addItem(
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
