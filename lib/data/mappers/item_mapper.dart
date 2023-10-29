import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roadmap/domain/entities/item.dart';
import 'package:roadmap/domain/entities/timelineItem.dart';

Item fromDocument(DocumentSnapshot doc) {
  final data = doc.data()! as Map<String, dynamic>;
  return Item(
    id: doc.id,
    title: data['title'] as String,
    description: data['description'] as String,
    deadline: (data['deadline'] as Timestamp).toDate(),
    imagePath: data['imagePath'] as String,
    isCompleted: data['isCompleted'] as bool,
    createdAt: (data['createdAt'] as Timestamp).toDate(),
  );
}

Map<String, dynamic> toDocument(Item item) {
  return {
    'id': item.id,
    'title': item.title,
    'description': item.description,
    'deadline': Timestamp.fromDate(item.deadline),
    'imagePath': item.imagePath,
    'isCompleted': item.isCompleted,
    'createdAt': Timestamp.fromDate(item.createdAt),
  }..remove('id');
}

TimelineItem fromTimeLineDocument(DocumentSnapshot doc) {
  final data = doc.data()! as Map<String, dynamic>;
  return TimelineItem(
    id: doc.id,
    title: data['title'] as String,
    description: data['description'] as String,
    deadline: (data['deadline'] as Timestamp).toDate(),
    isCompleted: data['isCompleted'] as bool,
    createdAt: (data['createdAt'] as Timestamp).toDate(),
  );
}

Map<String, dynamic> toTimeLineDocument(TimelineItem item) {
  return {
    'id': item.id,
    'title': item.title,
    'description': item.description,
    'deadline': Timestamp.fromDate(item.deadline),
    'isCompleted': item.isCompleted,
    'createdAt': Timestamp.fromDate(item.createdAt),
  }..remove('id');
}
