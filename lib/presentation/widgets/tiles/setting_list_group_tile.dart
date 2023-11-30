import 'package:flutter/material.dart';
import 'package:roadmap/presentation/views/setting/setting_list_item.dart';
import 'package:roadmap/presentation/widgets/tiles/setting_list_tile.dart';

class SettingListGroupTile extends StatelessWidget {
  const SettingListGroupTile(this.items, {super.key});
  final List<SettingListItem> items;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF343434),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: items.map<Widget>((item) {
          return Column(
            children: [
              SettingListTile(
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
