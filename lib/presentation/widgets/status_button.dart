import 'package:flutter/material.dart';
import 'package:roadmap/domain/types/status.dart';
import 'package:roadmap/presentation/widgets/status_image.dart';

/// ステータス切り替えボタン
class StatusButton extends StatelessWidget {
  const StatusButton({
    super.key,
    required this.status,
    required this.onPressed,
  });

  /// 現在のステータス
  final Status status;

  /// コールバック
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow,
        padding: const EdgeInsets.all(8),
      ),
      onPressed: onPressed,
      child: StatusImage(status: status),
    );
  }
}
