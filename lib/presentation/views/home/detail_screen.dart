import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/domain/entities/goal_item.dart';
import 'package:roadmap/domain/entities/roadmap_item.dart';
import 'package:roadmap/presentation/widgets/dialogs/delete_roadmap_item_dialog.dart';
import 'package:roadmap/presentation/widgets/modals/roadmap_modal_bottom_sheet.dart';
import 'package:roadmap/presentation/widgets/tiles/roadmap_tile.dart';

class DetailScreen extends HookConsumerWidget {
  const DetailScreen({super.key, required this.item});

  final GoalItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(roadmapViewModelProvider.notifier);
    final state = ref.watch(roadmapViewModelProvider);
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final selectedDate = useState<DateTime>(DateTime.now());

    useEffect(
      () {
        viewModel.retrieveRoadmapItems(item.id!);
        return null;
      },
      const [],
    );

    Future<void> showAddModalBottomSheet() async {
      selectedDate.value = DateTime.now();

      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        builder: (BuildContext context) {
          return RoadmapModalBottomSheet(
            titleController: titleController,
            descriptionController: descriptionController,
            selectedDate: selectedDate,
            modalTitle: 'Add Roadmap Item',
            buttonText: 'Add',
            onButtonPressed: () {
              viewModel
                ..addRoadmapItem(
                  itemId: item.id!,
                  title: titleController.text,
                  description: descriptionController.text,
                  deadline: selectedDate.value,
                )
                ..navigatePop();
            },
            onCancel: viewModel.navigatePop,
          );
        },
      );
    }

    Future<void> showEditModalBottomSheet({
      required String roadmapItemId,
      required String title,
      required String description,
      required DateTime deadline,
      required bool isCompleted,
    }) async {
      titleController.text = title;
      descriptionController.text = description;
      selectedDate.value = deadline;

      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        builder: (BuildContext context) {
          return RoadmapModalBottomSheet(
            titleController: titleController,
            descriptionController: descriptionController,
            selectedDate: selectedDate,
            modalTitle: 'Edit Roadmap Item',
            buttonText: 'Update',
            onButtonPressed: () {
              viewModel
                ..updateRoadmapItem(
                  goalItemId: item.id!,
                  updatedItem: RoadmapItem(
                    id: roadmapItemId,
                    title: titleController.text,
                    description: descriptionController.text,
                    deadline: selectedDate.value,
                    isCompleted: isCompleted,
                    createdAt: DateTime.now(),
                  ),
                )
                ..navigatePop();
            },
            onCancel: viewModel.navigatePop,
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
                      onEdit: () => showEditModalBottomSheet(
                        roadmapItemId: roadmapItem.id!,
                        title: roadmapItem.title,
                        description: roadmapItem.description,
                        deadline: roadmapItem.deadline,
                        isCompleted: roadmapItem.isCompleted,
                      ),
                      onDelete: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return DeleteRoadmapItemDialog(
                              itemId: item.id!,
                              roadmapItemId: roadmapItem.id!,
                              ref: ref,
                            );
                          },
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
                    onPressed: showAddModalBottomSheet,
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
