import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roadmap/domain/entities/goal_item.dart';

GoalItem fromDocument(DocumentSnapshot doc) {
  final data = doc.data()! as Map<String, dynamic>;
  return GoalItem(
    id: doc.id,
    title: data['title'] as String,
    description: data['description'] as String,
    deadline: (data['deadline'] as Timestamp).toDate(),
    imagePath: data['imagePath'] as String,
    isCompleted: data['isCompleted'] as bool,
    createdAt: (data['createdAt'] as Timestamp).toDate(),
  );
}

Map<String, dynamic> toDocument(GoalItem goalItem) {
  return {
    'id': goalItem.id,
    'title': goalItem.title,
    'description': goalItem.description,
    'deadline': Timestamp.fromDate(goalItem.deadline),
    'imagePath': goalItem.imagePath,
    'isCompleted': goalItem.isCompleted,
    'createdAt': Timestamp.fromDate(goalItem.createdAt),
  }..remove('id');
}
