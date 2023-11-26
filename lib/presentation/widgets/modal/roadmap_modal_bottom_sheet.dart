import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoadmapModalBottomSheet extends StatelessWidget {
  const RoadmapModalBottomSheet({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.selectedDate,
    required this.modalTitle,
    required this.buttonText,
    required this.onButtonPressed,
    required this.onCancel,
  });
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final ValueNotifier<DateTime> selectedDate;
  final String modalTitle;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              modalTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Title',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Description',
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Deadline',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextButton.icon(
            icon: const Icon(Icons.calendar_today),
            label: Text(DateFormat('yyyy-MM-dd').format(selectedDate.value)),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: selectedDate.value,
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );
              if (picked != null && picked != selectedDate.value) {
                selectedDate.value = picked;
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: onCancel,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black87,
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: onButtonPressed,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: Text(buttonText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
