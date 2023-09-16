import 'package:flutter/material.dart';
import 'package:roadmap/presentation/widgets/gap.dart';

/// 保存ボタン
class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.onPressed,
  });

  /// コールバック
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    /// アイコン
    const icon = Icon(Icons.check);

    /// 文字
    const text = Text(
      '保存',
    );

    /// レイアウト
    return FloatingActionButton.extended(
      heroTag: null,
      backgroundColor: Colors.yellow,
      onPressed: onPressed,
      label: Row(
        children: [
          icon,
          Gap.w(8),
          text,
        ],
      ),
    );
  }
}
