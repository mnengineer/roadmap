import 'package:flutter/material.dart';
import 'package:roadmap/presentation/widgets/gap.dart';

/// 追加ボタン
class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.onPressed,
  });

  /// コールバック
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    /// アイコン
    const icon = Icon(Icons.add);

    /// 文字
    const text = Text(
      '追加',
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
