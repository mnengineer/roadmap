import 'package:flutter/material.dart';
import 'package:roadmap/domain/types/status.dart';

/// ステータス文字
class StatusText extends StatelessWidget {
  const StatusText({
    super.key,
    required this.status,
  });

  /// ステータス
  final Status status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case Status.todo:
        return const Text(
          '未着手',
        );
      case Status.doing:
        return const Text(
          '進行中',
        );
      case Status.done:
        return const Text(
          '完了',
        );
    }
  }
}
