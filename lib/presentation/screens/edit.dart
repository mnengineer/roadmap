import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/application/di/infrastructure.dart';
import 'package:roadmap/application/di/usecases.dart';
import 'package:roadmap/application/state/editting_memo_provider.dart';
import 'package:roadmap/presentation/router/go_router.dart';
import 'package:roadmap/presentation/theme/text_strings.dart';
import 'package:roadmap/presentation/widgets/gap.dart';
import 'package:roadmap/presentation/widgets/save_button.dart';
import 'package:roadmap/presentation/widgets/status_button.dart';
import 'package:roadmap/presentation/widgets/status_text.dart';
import 'package:roadmap/presentation/widgets/text_edit_form.dart';

class EditScreen extends ConsumerWidget {
  const EditScreen({
    super.key,
    required this.memoId,
  });

  final String memoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// logger
    ref.watch(loggerProvider).debug('EditScreen.build()');

    /// 編集中のメモ
    final memo = ref.watch(edittingMemoProvider(memoId));

    /// ステータスボタン
    final statusButton = SizedBox(
      width: 60,
      height: 60,
      child: StatusButton(
        status: memo.status,
        onPressed: () {
          // ユースケースを呼び出す
          ref.read(updateMemoProvider(memoId)).editStatus();
        },
      ),
    );

    /// ステータス文字
    final statusText = StatusText(status: memo.status);

    /// テキスト編集フォーム
    final editForm = TextEditForm(
      value: memo.text,
      onChanged: (value) {
        // ユースケースを呼び出す
        ref.read(updateMemoProvider(memoId)).editText(value);
      },
    );

    /// 保存ボタン
    final saveButton = SaveButton(
      onPressed: () {
        // ユースケースを呼び出す
        ref.read(updateMemoProvider(memoId)).save(
          onValidateFailure: () {
            // NOP
          },
          onSuccess: () {
            // 成功したら前の画面に戻る
            ref.read(goRouterProvider).pop();
          },
        );
      },
    );

    /// 画面レイアウト
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: const Text(tOnBoardingTitle1),
      ),
      floatingActionButton: saveButton,
      body: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Row(
              children: [
                statusButton,
                Gap.w(8),
                statusText,
              ],
            ),
            Gap.h(20),
            editForm,
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
