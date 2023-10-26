import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/core/utils/date_utils.dart';
import 'package:roadmap/presentation/widgets/add_item_dialog.dart';

class HomeTab extends HookConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeTabViewModelProvider.notifier);
    final state = ref.watch(homeTabViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Roadmap')),
      body: state.when(
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

                  return ProviderScope(
                    child: Dismissible(
                      key: ValueKey(item.id),
                      background: Container(
                        color: Colors.red,
                      ),
                      onDismissed: (_) {
                        viewModel.deleteItem(
                          itemId: item.id!,
                        );
                      },
                      child: Column(
                        children: [
                          ListTile(
                            key: ValueKey(item.id),
                            title: Text(item.title),
                            subtitle: Text(
                              formatToJapaneseDate(item.createdAt),
                            ),
                            trailing: Checkbox(
                              value: item.isCompleted,
                              onChanged: (_) => viewModel.updateItem(
                                updatedItem: item.copyWith(
                                  isCompleted: !item.isCompleted,
                                ),
                              ),
                            ),
                            onTap: () => AddItemDialog.show(context, item),
                            onLongPress: () => viewModel.deleteItem(
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
    );
  }
}
