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
    final datePickerErrorText = useState<String?>(null); // 追加
    final selectedBackgroundColor = useState<Color?>(tDarkColor);
    final formKey = GlobalKey<FormState>(); // 追加

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
              if (formKey.currentState!.validate()) {
                if (selectedDate.value == null) {
                  datePickerErrorText.value = '期日を選択してください';
                } else {
                  datePickerErrorText.value = null;
                  viewModel
                    ..updateGoalItem(
                      updatedItem: goalItem.copyWith(
                        title: titleController.text.trim(),
                        description: descriptionController.text.trim(),
                        deadline: selectedDate.value ?? DateTime.now(),
                        backgroundColorValue:
                            selectedBackgroundColor.value!.value,
                      ),
                    )
                    ..navigatePop();
                }
              }
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabeledTextFormWidget(
                  label: 'タイトル',
                  hint: 'タイトルを入力',
                  icon: Icons.title_rounded,
                  maxLines: 1,
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'タイトルは必須です';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                LabeledTextFormWidget(
                  label: '説明',
                  hint: '説明を入力',
                  icon: Icons.description_rounded,
                  maxLines: 10,
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '説明は必須です';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DatePicker(
                  label: '達成期日を選択',
                  selectedDate: selectedDate,
                  errorText: datePickerErrorText,
                ),
                const SizedBox(height: 20),
                ImagePicker(
                  label: '背景画像',
                  selectedBackgroundColor: selectedBackgroundColor,
                  onTap: (color) => selectedBackgroundColor.value = color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
