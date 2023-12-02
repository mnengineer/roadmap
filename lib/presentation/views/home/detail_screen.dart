import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/constants/colors.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/core/utils/date_utils.dart';
import 'package:roadmap/domain/entities/goal_item.dart';
import 'package:roadmap/domain/entities/roadmap_item.dart';
import 'package:roadmap/presentation/viewmodels/home/goal_viewmodel.dart';
import 'package:roadmap/presentation/viewmodels/home/roadmap_viewmodel.dart';
import 'package:roadmap/presentation/widgets/dialogs/delete_item_dialog.dart';
import 'package:roadmap/presentation/widgets/modals/roadmap_modal_bottom_sheet.dart';
import 'package:roadmap/presentation/widgets/tiles/roadmap_tile.dart';

class DetailScreen extends HookConsumerWidget {
  const DetailScreen({super.key, required this.goalItem});

  final GoalItem goalItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalViewModel = ref.watch(goalViewModelProvider.notifier);
    final goalState = ref.watch(goalViewModelProvider);
    final roadmapViewModel = ref.watch(roadmapViewModelProvider.notifier);
    final roadmapState = ref.watch(roadmapViewModelProvider);

    final isLoading = useState(true);

    useEffect(
      () {
        Future(() {
          roadmapViewModel.retrieveRoadmapItems(goalItem.id!).then((_) {
            isLoading.value = false;
          });
        });
        return null;
      },
      [goalItem.id],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'アイテム詳細',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              goalState.when(
                data: (items) {
                  goalViewModel.navigateToEdit(
                    goalItem: items.firstWhere(
                      (item) => item.id == goalItem.id!,
                      orElse: () => GoalItem(
                        id: '',
                        title: '',
                        description: '',
                        deadline: DateTime.now(),
                        backgroundColorValue: Colors.white.value,
                        createdAt: DateTime.now(),
                      ),
                    ),
                  );
                },
                loading: () {},
                error: (error, _) => Text(error.toString()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return DeleteItemDialog(
                    title: 'Delete Goal Item',
                    content: 'Are you sure you want to delete this item?',
                    onDelete: () async {
                      await goalViewModel.deleteGoalItem(
                        itemId: goalItem.id!,
                      );
                      goalViewModel.navigateToHome();
                      await roadmapViewModel.retrieveRoadmapItems(goalItem.id!);
                    },
                    onCancel: goalViewModel.navigatePop,
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopContent(
              context,
              goalViewModel,
              goalState,
              goalItem.id!,
            ),
            const SizedBox(height: 20),
            if (isLoading.value)
              const Center(child: CircularProgressIndicator())
            else
              _buildBottomContent(
                context,
                roadmapViewModel,
                roadmapState,
                goalItem.id!,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopContent(
    BuildContext context,
    GoalViewModel goalViewModel,
    AsyncValue<List<GoalItem>> goalState,
    String goalItemId,
  ) {
    return goalState.when(
      data: (items) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                items
                    .firstWhere(
                      (item) => item.id == goalItemId,
                      orElse: GoalItem.empty,
                    )
                    .title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: tWhiteColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                items
                    .firstWhere(
                      (item) => item.id == goalItemId,
                      orElse: GoalItem.empty,
                    )
                    .description,
                style: const TextStyle(
                  fontSize: 18,
                  color: tWhiteColor,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: items
                                .firstWhere(
                                  (item) => item.id == goalItemId,
                                  orElse: GoalItem.empty,
                                )
                                .deadline
                                .difference(DateTime.now())
                                .inDays <=
                            0
                        ? Colors.red
                        : Colors.white,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    formatDeadline(
                      items
                          .firstWhere(
                            (item) => item.id == goalItemId,
                            orElse: GoalItem.empty,
                          )
                          .deadline,
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: tWhiteColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text(error.toString()),
    );
  }

  Widget _buildBottomContent(
    BuildContext context,
    RoadmapViewmodel roadmapViewModel,
    AsyncValue<List<RoadmapItem>> roadmapState,
    String goalItemId,
  ) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final selectedDate = useState<DateTime>(DateTime.now());

    Future<void> showAddModalBottomSheet() async {
      titleController.clear();
      descriptionController.clear();
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
              roadmapViewModel
                ..addRoadmapItem(
                  goalItemId: goalItem.id!,
                  title: titleController.text,
                  description: descriptionController.text,
                  deadline: selectedDate.value,
                )
                ..navigatePop();
            },
            onCancel: roadmapViewModel.navigatePop,
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
              roadmapViewModel
                ..updateRoadmapItem(
                  goalItemId: goalItem.id!,
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
            onCancel: roadmapViewModel.navigatePop,
          );
        },
      );
    }

    return roadmapState.when(
      data: (roadmapItems) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      return DeleteItemDialog(
                        title: 'Delete Roadmap Item',
                        content: 'Are you sure you want to delete this item?',
                        onDelete: () async {
                          await roadmapViewModel.deleteRoadmapItem(
                            itemId: goalItem.id!,
                            roadmapItemId: roadmapItem.id!,
                          );
                          roadmapViewModel.navigatePop();
                          await roadmapViewModel
                              .retrieveRoadmapItems(goalItem.id!);
                        },
                        onCancel: roadmapViewModel.navigatePop,
                      );
                    },
                  );
                },
                onToggleCompletion: () {
                  roadmapViewModel.updateRoadmapItem(
                    goalItemId: goalItem.id!,
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
    );
  }
}
