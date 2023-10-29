// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/domain/entities/item.dart';
import 'package:roadmap/domain/entities/timelineItem.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DetailScreen extends HookConsumerWidget {
  const DetailScreen({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timelineViewModel = ref.watch(detailViewModelProvider.notifier);
    final timelineState = ref.watch(detailViewModelProvider);

    // useEffectフックを使用してretrieveTimelineItemsメソッドを呼び出す
    useEffect(
      () {
        timelineViewModel.retrieveTimelineItems(item.id!);
        return null; // オプショナルなクリーンアップ関数を返すことができます
      },
      const [],
    );

    Future<void> showAddTimelineItemDialog(
      BuildContext context,
      WidgetRef ref,
    ) async {
      var title = '';
      var description = '';
      var deadline =
          DateTime.now().add(const Duration(days: 7)); // Default deadline

      Future<void> selectDate(BuildContext context) async {
        final picked = await showDatePicker(
              context: context,
              initialDate: deadline,
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
            ) ??
            deadline;
        deadline = picked;
      }

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Timeline Item'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) => title = value,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                  ),
                  TextField(
                    onChanged: (value) => description = value,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => selectDate(
                      context,
                    ),
                    child: Text(
                      'Select Deadline: ${DateFormat('yyyy-MM-dd').format(deadline)}',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  timelineViewModel.addTimelineItem(
                    itemId: item.id!,
                    title: title,
                    description: description,
                    deadline: deadline,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
    }

    Widget _buildTimelineTile(
      String title,
      String subtitle,
      bool isCompleted,
      DateTime deadline,
      String timelineItemId,
    ) {
      Future<void> showEditTimelineItemDialog(
        BuildContext context,
        WidgetRef ref,
        String title,
        String description,
        DateTime deadline,
        String timelineItemId,
      ) async {
        var editedTitle = title;
        var editedDescription = description;
        DateTime editedDeadline = deadline;

        Future<void> selectDate(BuildContext context) async {
          final picked = await showDatePicker(
                context: context,
                initialDate: editedDeadline,
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              ) ??
              editedDeadline;
          editedDeadline = picked;
        }

        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Edit Timeline Item'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) => editedTitle = value,
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: TextEditingController(text: title),
                    ),
                    TextField(
                      onChanged: (value) => editedDescription = value,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      controller: TextEditingController(text: description),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => selectDate(context),
                      child: Text(
                          'Select Deadline: ${DateFormat('yyyy-MM-dd').format(editedDeadline)}'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    timelineViewModel.updateTimelineItem(
                      itemId: item.id!,
                      updatedItem: TimelineItem(
                        id: timelineItemId,
                        title: editedTitle,
                        description: editedDescription,
                        deadline: editedDeadline,
                        createdAt: DateTime.now(),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.update),
                ),
              ],
            );
          },
        );
      }

      return TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.1,
        beforeLineStyle: isCompleted
            ? const LineStyle(color: Colors.purple)
            : const LineStyle(color: Colors.grey),
        indicatorStyle: isCompleted
            ? IndicatorStyle(
                width: 20,
                color: Colors.purple,
                padding: const EdgeInsets.all(6),
                iconStyle: IconStyle(
                  iconData: Icons.check, // Checkmark icon
                  color: Colors.white,
                ),
              )
            : const IndicatorStyle(width: 20, color: Colors.grey),
        endChild: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: isCompleted ? Colors.purple : Colors.grey,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showEditTimelineItemDialog(
                            context,
                            ref,
                            title,
                            subtitle,
                            deadline,
                            timelineItemId,
                          );
                        },
                        child: const Icon(Icons.edit, color: Colors.blue),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          timelineViewModel.deleteTimelineItem(
                            itemId: item.id!,
                            timelineItemId: timelineItemId,
                          );
                        },
                        child: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(subtitle),
              const SizedBox(height: 4),
              Text('Deadline: ${DateFormat('yyyy-MM-dd').format(deadline)}'),
            ],
          ),
        ),
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
              timelineViewModel.navigateToEdit(item: item);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              timelineViewModel.deleteTimelineItem(
                itemId: item.id!,
                timelineItemId: '',
              );
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: timelineState.when(
            data: (timelineItems) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (timelineItems.isEmpty)
                    const Center(
                      child: Text(
                        'タスクがありません',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  else ...[
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
                    for (final timelineItem in timelineItems)
                      _buildTimelineTile(
                        timelineItem.title,
                        timelineItem.description,
                        timelineItem.isCompleted,
                        timelineItem.deadline,
                        timelineItem.id!,
                      ),
                    const SizedBox(height: 20),
                  ],
                  ElevatedButton(
                    onPressed: () => showAddTimelineItemDialog(context, ref),
                    child: const Text('Add Timeline Item'),
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
