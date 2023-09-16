import 'package:flutter/material.dart';
import 'package:roadmap/domain/types/status.dart';

/// ステータス画像
class StatusImage extends StatelessWidget {
  const StatusImage({
    super.key,
    required this.status,
  });

  /// ステータス
  final Status status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case Status.todo:
        return Image.asset(
          'assets/images/dashboard/dash-01.png',
        );
      case Status.doing:
        return Image.asset(
          'assets/images/dashboard/dash-01.png',
        );
      case Status.done:
        return Image.asset(
          'assets/images/dashboard/dash-01.png',
        );
    }
  }
}
