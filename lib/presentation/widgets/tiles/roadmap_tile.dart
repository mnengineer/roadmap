import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roadmap/core/constants/colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

class RoadmapTile extends StatelessWidget {
  const RoadmapTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.deadline,
    required this.roadmapItemId,
    required this.isFirst,
    required this.isLast,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleCompletion,
  });
  final String title;
  final String subtitle;
  final bool isCompleted;
  final DateTime deadline;
  final String roadmapItemId;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleCompletion;

  @override
  Widget build(BuildContext context) {
    final lineColor = isCompleted
        ? (Colors.blue[700] ?? Colors.blue)
        : (Colors.blue[100] ?? Colors.blue);
    final iconColor =
        isCompleted ? tWhiteColor : (Colors.blue[100] ?? tWhiteColor);
    final textColor = isCompleted ? Colors.red : tDarkColor;

    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(
        color: isFirst ? Colors.transparent : lineColor,
      ),
      afterLineStyle: LineStyle(
        color: isLast ? Colors.transparent : lineColor,
      ),
      indicatorStyle: IndicatorStyle(
        width: 30,
        color: lineColor,
        iconStyle: IconStyle(
          iconData: isCompleted ? Icons.check : Icons.circle,
          color: iconColor,
          fontSize: 20,
        ),
      ),
      endChild: Container(
        margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: tDarkColor,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_month_rounded),
                const SizedBox(width: 6),
                Text(
                  DateFormat('yyyy-MM-dd').format(deadline),
                  style: const TextStyle(
                    color: tDarkColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onToggleCompletion,
                  child: Text(
                    isCompleted ? 'Complete' : 'Incomplete',
                    style: TextStyle(color: textColor),
                  ),
                ),
                InkWell(
                  onTap: onEdit,
                  child: const Icon(Icons.edit, color: Colors.blue),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: onDelete,
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
