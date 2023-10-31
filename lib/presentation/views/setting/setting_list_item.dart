import 'package:flutter/material.dart';

class SettingListItem {
  SettingListItem(
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
