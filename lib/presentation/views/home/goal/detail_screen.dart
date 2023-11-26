import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/domain/entities/goal_item.dart';
import 'package:roadmap/presentation/widgets/modal/roadmap_add_modal_bottom_sheet.dart';
import 'package:roadmap/presentation/widgets/modal/roadmap_edit_modal_bottom_sheet.dart';
import 'package:roadmap/presentation/widgets/tile/roadmap_tile.dart';

class DetailScreen extends HookConsumerWidget {
  const DetailScreen({super.key, required this.item});

  final GoalItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(roadmapViewModelProvider.notifier);
    final state = ref.watch(roadmapViewModelProvider);
    final selectedDate = useState<DateTime>(DateTime.now());

    useEffect(
      () {
        viewModel.retrieveRoadmapItems(item.id!);
        return null;
      },
      const [],
    );

    Future<void> showDeleteRoadmapItemDialog({
      required String itemId,
      required String roadmapItemId,
    }) async {
      await showDialog<void>(
        context: context,
        builder: (context) {
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
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'アイテム詳細',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.grey[900],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              viewModel.navigateToEdit(item: item);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              viewModel
                ..deleteRoadmapItem(
                  itemId: item.id!,
                  roadmapItemId: '',
                )
                ..navigatePop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: state.when(
            data: (roadmapItems) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'タイトル: ${item.title}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '説明: ${item.description}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '期日: ${DateFormat('yyyy-MM-dd').format(item.deadline)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  for (final roadmapItem in roadmapItems)
                    RoadmapTile(
                      title: roadmapItem.title,
                      subtitle: roadmapItem.description,
                      isCompleted: roadmapItem.isCompleted,
                      deadline: roadmapItem.deadline,
                      roadmapItemId: roadmapItem.id!,
                      isFirst: roadmapItems.first == roadmapItem,
                      isLast: roadmapItems.last == roadmapItem,
                      onEdit: () {
                        showRoadmapEditModalBottomSheet(
                          context: context,
                          ref: ref,
                          selectedDate: selectedDate,
                          item: item,
                          roadmapItemId: roadmapItem.id!,
                          title: roadmapItem.title,
                          description: roadmapItem.description,
                          deadline: roadmapItem.deadline,
                          isCompleted: roadmapItem.isCompleted,
                        );
                      },
                      onDelete: () {
                        showDeleteRoadmapItemDialog(
                          itemId: item.id!,
                          roadmapItemId: roadmapItem.id!,
                        );
                      },
                      onToggleCompletion: () {
                        viewModel.updateRoadmapItem(
                          goalItemId: item.id!,
                          updatedItem: roadmapItem.copyWith(
                            isCompleted: !roadmapItem.isCompleted,
                          ),
                        );
                      },
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => showRoadmapAddModalBottomSheet(
                      context: context,
                      ref: ref,
                      selectedDate: selectedDate,
                      item: item,
                    ),
                    child: const Text('Add Roadmap Item'),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text(error.toString()),
          ),
        ),
      ),
    );
  }
}
