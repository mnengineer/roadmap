import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/domain/entities/goal_item.dart';
import 'package:roadmap/presentation/widgets/forms/labeld_text_form_widget.dart';
import 'package:roadmap/presentation/widgets/pickers/date_picker.dart';

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
            LabeledTextFormWidget(
              label: 'タイトル',
              hint: 'タイトルを入力',
              controller: titleController,
              isRequired: true,
            ),
            const SizedBox(height: 12),
            LabeledTextFormWidget(
              label: '説明',
              hint: '説明を入力',
              controller: descriptionController,
            ),
            const SizedBox(height: 12),
            DatePicker(
              label: '期限',
              hint: '期限を選択',
              selectedDate: selectedDate,
              isRequired: true,
            ),
          ],
        ),
      ),
    );
  }
}
