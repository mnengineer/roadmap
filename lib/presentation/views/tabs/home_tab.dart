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
            fontSize: 20,
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
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/dashboard/3.jpeg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          state.when(
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
                            imagePath: 'assets/images/dashboard/34.jpg',
                            onTap: () => AddItemDialog.show(context, item),
                          ),
                          const Divider(height: 2),
                        ],
                      );
                    },
                  ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text(error.toString()),
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
  });
  final String title;
  final String description;
  final int progress;
  final String imagePath;
  final VoidCallback onTap;

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
