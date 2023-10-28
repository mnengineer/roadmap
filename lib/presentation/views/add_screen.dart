import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/di/providers.dart';

class AddScreen extends HookConsumerWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeTabViewModelProvider.notifier);
    final textController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: viewModel.navigatePop,
          icon: const Icon(Icons.close),
        ),
        title: const Text('アイテムを追加'),
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
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  viewModel.addItem(
                    title: textController.text.trim(),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('追加'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
