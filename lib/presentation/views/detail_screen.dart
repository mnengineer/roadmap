import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/domain/entities/item.dart';

class DetailScreen extends HookConsumerWidget {
  const DetailScreen({super.key, required this.item});

  final Item item;
  bool get isUpdating => item.id != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeTabViewModelProvider.notifier);
    final titleController = useTextEditingController(text: item.title);
    final descriptionController = useTextEditingController(
      text: item.description,
    );
    final selectedDate = useState<DateTime?>(item.deadline);

    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdating ? 'アイテムを更新' : 'アイテムを追加'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'タイトル'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              autofocus: true,
              decoration: const InputDecoration(hintText: '説明'),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: selectedDate.value ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (date != null) {
                  selectedDate.value = date;
                }
              },
              child: Text(
                selectedDate.value == null
                    ? '期日を選択'
                    : DateFormat('yyyy-MM-dd').format(selectedDate.value!),
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
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
                            title: titleController.text.trim(),
                            description: descriptionController.text.trim(),
                            deadline: selectedDate.value ?? DateTime.now(),
                          ),
                        )
                      : viewModel.addItem(
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          deadline: selectedDate.value ?? DateTime.now(),
                          imagePath: '',
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
