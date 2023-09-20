import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/domain/entities/item_model.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemList = ref.watch(itemListProvider);
    final itemListNotifier = ref.watch(itemListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Roadmap')),
      body: itemList.when(
        data: (items) => items.isEmpty
            ? const Center(
                child: Text(
                  'タスクがありません',
                  style: TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];
                  String getTodayDate() {
                    initializeDateFormatting('ja');
                    return DateFormat('yyyy/MM/dd HH:mm', 'ja')
                        .format(item.createdAt);
                  }

                  return ProviderScope(
                    child: Dismissible(
                      key: ValueKey(item.id),
                      background: Container(
                        color: Colors.red,
                      ),
                      onDismissed: (_) {
                        itemListNotifier.deleteItem(
                          itemId: item.id!,
                        );
                      },
                      child: Column(
                        children: [
                          ListTile(
                            key: ValueKey(item.id),
                            title: Text(item.title),
                            subtitle: Text(getTodayDate()),
                            trailing: Checkbox(
                              value: item.isCompleted,
                              onChanged: (_) => itemListNotifier.updateItem(
                                updatedItem: item.copyWith(
                                  isCompleted: !item.isCompleted,
                                ),
                              ),
                            ),
                            onTap: () => AddItemDialog.show(context, item),
                            onLongPress: () => itemListNotifier.deleteItem(
                              itemId: item.id!,
                            ),
                          ),
                          const Divider(height: 2),
                        ],
                      ),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Text(error.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddItemDialog.show(context, Item.empty()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

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
