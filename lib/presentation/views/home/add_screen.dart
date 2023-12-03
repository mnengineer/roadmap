import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/constants/colors.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/presentation/widgets/forms/labeld_text_form_widget.dart';
import 'package:roadmap/presentation/widgets/pickers/date_picker.dart';
import 'package:roadmap/presentation/widgets/pickers/image_picker.dart';

class AddScreen extends HookConsumerWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(goalViewModelProvider.notifier);
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final selectedDate = useState<DateTime?>(null);
    final datePickerErrorText = useState<String?>(null);
    final selectedBackgroundColor = useState<Color?>(tDarkColor);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: viewModel.navigatePop,
          icon: const Icon(Icons.close),
        ),
        title: const Text(
          '新規目標の追加',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (selectedDate.value == null) {
                  datePickerErrorText.value = '期日を選択してください';
                } else {
                  datePickerErrorText.value = null;
                  viewModel
                    ..addGoalItem(
                      title: titleController.text.trim(),
                      description: descriptionController.text.trim(),
                      deadline: selectedDate.value ?? DateTime.now(),
                      backgroundColor:
                          selectedBackgroundColor.value ?? tDarkColor,
                    )
                    ..navigatePop();
                }
              }
            },
            icon: const Icon(Icons.check),
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
                  label: '背景色',
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
