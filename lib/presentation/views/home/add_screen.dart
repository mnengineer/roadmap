import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/constants/colors.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/presentation/widgets/dialogs/error_dialog.dart';
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
    final selectedBackgroundColor = useState<Color?>(tDarkColor);
    final errorDialog = ref.read(errorDialogProvider);

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
              if (titleController.text.isEmpty || selectedDate.value == null) {
                errorDialog.showErrorDialog(
                  context,
                  title: '必須項目が未入力です。',
                  message: '必須項目が未入力です。',
                );
              } else {
                viewModel
                  ..addItem(
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                    deadline: selectedDate.value ?? DateTime.now(),
                    backgroundColor:
                        selectedBackgroundColor.value ?? tDarkColor,
                  )
                  ..navigatePop();
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
