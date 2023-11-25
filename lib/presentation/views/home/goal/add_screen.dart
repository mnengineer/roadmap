import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/presentation/widgets/dialog/error_dialog.dart';
import 'package:roadmap/presentation/widgets/form/labeld_text_form_widget.dart';
import 'package:roadmap/presentation/widgets/picker/date_picker_widget.dart';
import 'package:roadmap/presentation/widgets/picker/image_picker_widget.dart';

class AddScreen extends HookConsumerWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(goalViewModelProvider.notifier);
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final selectedDate = useState<DateTime?>(null);
    final selectedImagePath =
        useState<String?>('assets/images/dashboard/10.jpeg');
    final errorDialog = ref.read(errorDialogProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: viewModel.navigatePop,
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        title: const Text(
          '新規目標の追加',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
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
                    imagePath: selectedImagePath.value ?? '',
                  )
                  ..navigatePop();
              }
            },
            icon: const Icon(Icons.check, color: Colors.black),
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
              DatePickerWidget(
                label: '期限',
                hint: '期限を選択',
                selectedDate: selectedDate,
                isRequired: true,
              ),
              const SizedBox(height: 12),
              ImagePickerWidget(
                label: '背景画像',
                selectedImagePath: selectedImagePath,
                onImageTap: (path) => selectedImagePath.value = path,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
