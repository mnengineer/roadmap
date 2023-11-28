import 'package:flutter/material.dart';

class SettingListTile extends StatelessWidget {
  const SettingListTile(
    this.title,
    this.icon,
    this.iconColor, {
    super.key,
    this.onTap,
  });
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
