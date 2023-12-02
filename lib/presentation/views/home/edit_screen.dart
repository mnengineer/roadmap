import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/constants/colors.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/domain/entities/goal_item.dart';
import 'package:roadmap/presentation/widgets/forms/labeld_text_form_widget.dart';
import 'package:roadmap/presentation/widgets/pickers/date_picker.dart';
import 'package:roadmap/presentation/widgets/pickers/image_picker.dart';

class EditScreen extends HookConsumerWidget {
  const EditScreen({super.key, required this.goalItem});

  final GoalItem goalItem;
  bool get isUpdating => goalItem.id != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(goalViewModelProvider.notifier);
    final titleController = useTextEditingController(text: goalItem.title);
    final descriptionController = useTextEditingController(
      text: goalItem.description,
    );
    final selectedDate = useState<DateTime?>(goalItem.deadline);
    final selectedBackgroundColor = useState<Color?>(tDarkColor);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '編集',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.update),
            onPressed: () {
              viewModel
                ..updateGoalItem(
                  updatedItem: goalItem.copyWith(
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                    deadline: selectedDate.value ?? DateTime.now(),
                    backgroundColorValue: selectedBackgroundColor.value!.value,
                  ),
                )
                ..navigatePop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                label: '期日',
                hint: '期日を選択',
                selectedDate: selectedDate,
                isRequired: true,
              ),
              const SizedBox(height: 12),
              ImagePicker(
                label: '背景画像',
                selectedBackgroundColor: selectedBackgroundColor,
                onTap: (color) => selectedBackgroundColor.value = color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
