import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/core/utils/date_utils.dart';
import 'package:roadmap/presentation/views/mypage_screen.dart';
import 'package:roadmap/presentation/widgets/add_item_dialog.dart';

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
                    child: const MyPageScreen(),
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
            height: 40,
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
                            ListTile(
                              title: item.title,
                              description:
                                  '期日：${formatToJapaneseDate(item.createdAt)}',
                              progress: 50,
                              imagePath: 'assets/images/dashboard/7.jpeg',
                              onTap: () => AddItemDialog.show(context, item),
                              isCompleted: item.isCompleted,
                            ),
                            const Divider(height: 2),
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

class ListTile extends StatelessWidget {
  const ListTile({
    super.key,
    required this.title,
    required this.description,
    required this.progress,
    required this.imagePath,
    required this.onTap,
    required this.isCompleted,
  });
  final String title;
  final String description;
  final int progress;
  final String imagePath;
  final VoidCallback onTap;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: progress / 100,
                    backgroundColor: Colors.grey,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.yellow,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '$progress%',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FilterTag extends HookConsumerWidget {
  const FilterTag({super.key, required this.title, required this.onTap});
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTag = ref.watch(selectedTagProvider);
    final isSelected = selectedTag == title;
    return GestureDetector(
      onTap: () {
        ref.read(selectedTagProvider.notifier).state = title;
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Chip(
            label: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.grey[100] : Colors.grey[900],
              ),
            ),
            avatar: isSelected
                ? const Icon(Icons.check, color: Colors.white)
                : null,
            backgroundColor: isSelected ? Colors.grey[900] : Colors.grey[100],
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: isSelected ? Colors.grey : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
      ),
    );
  }
}
