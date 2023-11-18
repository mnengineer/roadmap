import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/domain/entities/goal_item.dart';

class EditScreen extends HookConsumerWidget {
  const EditScreen({super.key, required this.item});

  final GoalItem item;
  bool get isUpdating => item.id != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(goalViewModelProvider.notifier);
    final titleController = useTextEditingController(text: item.title);
    final descriptionController = useTextEditingController(
      text: item.description,
    );
    final selectedDate = useState<DateTime?>(item.deadline);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '編集',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.grey[900],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.update),
            onPressed: () {
              viewModel.updateItem(
                updatedItem: item.copyWith(
                  title: titleController.text.trim(),
                  description: descriptionController.text.trim(),
                  deadline: selectedDate.value ?? DateTime.now(),
                ),
              );
              Navigator.of(context).pop();
            },
          ),
        ],
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
          ],
        ),
      ),
    );
  }
}
