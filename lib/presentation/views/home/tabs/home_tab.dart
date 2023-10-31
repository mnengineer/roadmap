import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/core/utils/date_utils.dart';
import 'package:roadmap/presentation/views/setting/setting_screen.dart';
import 'package:roadmap/presentation/widgets/tag/filter_tag.dart';
import 'package:roadmap/presentation/widgets/tile/home_list_tile.dart';

class HomeTab extends HookConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeTabViewModelProvider.notifier);
    final state = ref.watch(homeTabViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Roadmap',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.grey[900],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                builder: (context) {
                  final height = MediaQuery.of(context).size.height;
                  final desiredHeight = height * 0.9;
                  return SizedBox(
                    height: desiredHeight,
                    child: const SettingScreen(),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.person_outline,
              size: 24,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 54,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FilterTag(
                  title: 'すべて',
                  onTap: viewModel.filterItems,
                ),
                FilterTag(
                  title: '完了',
                  onTap: () => viewModel.filterItems(isCompleted: true),
                ),
                FilterTag(
                  title: '未完了',
                  onTap: () => viewModel.filterItems(isCompleted: false),
                ),
              ],
            ),
          ),
          Expanded(
            child: state.when(
              data: (items) => items.isEmpty
                  ? const Center(
                      child: Text(
                        'タスクがありません',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = items[index];
                        return Column(
                          children: [
                            HomeListTile(
                              title: item.title,
                              deadline: formatDeadline(item.deadline),
                              progress: 80,
                              imagePath: item.imagePath,
                              onTap: () {
                                viewModel.navigateToDetail(item: item);
                              },
                              isCompleted: item.isCompleted,
                            ),
                          ],
                        );
                      },
                    ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Text(error.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
