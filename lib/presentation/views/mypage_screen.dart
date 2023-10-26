import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/di/providers.dart';

class MyPageScreen extends HookConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(mypageViewModelProvider.notifier);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[900]!.withOpacity(0.9),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Settings',
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                CustomListTile(context, '一般', Icons.settings, Colors.blue),
                const SizedBox(height: 16),
                GroupedListTiles(
                  context,
                  [
                    ListItem('シェアする', Icons.ios_share, Colors.blue),
                    ListItem('アプリを評価する', Icons.star, Colors.orange),
                  ],
                ),
                const SizedBox(height: 16),
                GroupedListTiles(
                  context,
                  [
                    ListItem('ヘルプ', Icons.help, Colors.green),
                    ListItem('お問い合わせ', Icons.mail, Colors.purple),
                    ListItem('サービス利用規約', Icons.description, Colors.grey),
                    ListItem('プライバシーポリシー', Icons.privacy_tip, Colors.teal),
                    ListItem('バージョン', Icons.info, Colors.brown),
                  ],
                ),
                const SizedBox(height: 16),
                GroupedListTiles(
                  context,
                  [
                    ListItem(
                      'ログアウト',
                      Icons.logout,
                      Colors.red,
                      onTap: () => viewModel.logout,
                    ),
                    ListItem(
                      '退会',
                      Icons.delete_forever,
                      Colors.red,
                      onTap: () => viewModel.deleteAccount,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile(
    this.context,
    this.title,
    this.icon,
    this.iconColor, {
    super.key,
    this.onTap,
  });
  final BuildContext context;
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white),
        onTap: onTap,
      ),
    );
  }
}

class GroupedListTiles extends StatelessWidget {
  const GroupedListTiles(this.context, this.items, {super.key});
  final BuildContext context;
  final List<ListItem> items;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: items.map<Widget>((item) {
          return Column(
            children: [
              CustomListTile(
                context,
                item.title,
                item.icon,
                item.iconColor,
                onTap: item.onTap,
              ),
              if (item != items.last)
                const Divider(color: Colors.grey, height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class ListItem {
  ListItem(
    this.title,
    this.icon,
    this.iconColor, {
    this.onTap,
  });
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;
}
