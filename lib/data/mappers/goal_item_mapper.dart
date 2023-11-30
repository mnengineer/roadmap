import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roadmap/domain/entities/goal_item.dart';

GoalItem fromDocument(DocumentSnapshot doc) {
  final data = doc.data()! as Map<String, dynamic>;
  return GoalItem(
    id: doc.id,
    title: data['title'] as String,
    description: data['description'] as String,
    deadline: (data['deadline'] as Timestamp).toDate(),
    backgroundColorValue: data['backgroundColorValue'] as int,
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
    'backgroundColorValue': goalItem.backgroundColorValue,
    'isCompleted': goalItem.isCompleted,
    'createdAt': Timestamp.fromDate(goalItem.createdAt),
  }..remove('id');
}
