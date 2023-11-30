import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/constants/colors.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/domain/entities/goal_item.dart';
import 'package:roadmap/presentation/viewmodels/home/goal_viewmodel.dart';
import 'package:roadmap/presentation/views/setting/setting_screen.dart';
import 'package:roadmap/presentation/widgets/tiles/home_list_tile.dart';

class HomeTabScreen extends HookConsumerWidget {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(goalViewModelProvider.notifier);
    final state = ref.watch(goalViewModelProvider);
    final tabController = useTabController(initialLength: 3);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Roadmap',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
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
              Icons.settings_outlined,
              size: 24,
            ),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          indicatorColor: tWhiteColor,
          indicatorWeight: 3,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
          labelColor: tWhiteColor,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.transparent;
              }
              return null;
            },
          ),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Completed'),
            Tab(text: 'Uncompleted'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          _buildTabContent(context, viewModel, state, null),
          _buildTabContent(context, viewModel, state, true),
          _buildTabContent(context, viewModel, state, false),
        ],
      ),
    );
  }

  Widget _buildTabContent(
    BuildContext context,
    GoalViewModel viewModel,
    AsyncValue<List<GoalItem>> state,
    bool? isCompleted,
  ) {
    return state.when(
      data: (items) {
        final filteredItems = isCompleted == null
            ? items
            : items.where((item) => item.isCompleted == isCompleted).toList();

        return filteredItems.isEmpty
            ? const Center(
                child: Text(
                  'タスクがありません',
                  style: TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = filteredItems[index];
                  return Column(
                    children: [
                      HomeListTile(
                        title: item.title,
                        deadline: item.deadline,
                        progress: 80,
                        backgroundColor: Color(item.backgroundColorValue),
                        onTap: () {
                          viewModel.navigateToDetail(item: item);
                        },
                        isCompleted: item.isCompleted,
                      ),
                    ],
                  );
                },
              );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text(error.toString()),
    );
  }
}
