import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/di/providers.dart';

class DeleteRoadmapItemDialog extends StatelessWidget {
  const DeleteRoadmapItemDialog({
    super.key,
    required this.itemId,
    required this.roadmapItemId,
    required this.ref,
  });
  final String itemId;
  final String roadmapItemId;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(roadmapViewModelProvider.notifier);

    return AlertDialog(
      title: const Text('Delete Item'),
      content: const Text('Are you sure you want to delete this item?'),
      actions: [
        TextButton(
          onPressed: viewModel.navigatePop,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await viewModel.deleteRoadmapItem(
              itemId: itemId,
              roadmapItemId: roadmapItemId,
            );
            viewModel.navigatePop();
            await viewModel.retrieveRoadmapItems(itemId);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
