import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roadmap/domain/entities/roadmap_item.dart';

RoadmapItem fromDocument(DocumentSnapshot doc) {
  final data = doc.data()! as Map<String, dynamic>;
  return RoadmapItem(
    id: doc.id,
    title: data['title'] as String,
    description: data['description'] as String,
    deadline: (data['deadline'] as Timestamp).toDate(),
    isCompleted: data['isCompleted'] as bool,
    createdAt: (data['createdAt'] as Timestamp).toDate(),
  );
}

Map<String, dynamic> toDocument(RoadmapItem roadmapItem) {
  return {
    'id': roadmapItem.id,
    'title': roadmapItem.title,
    'description': roadmapItem.description,
    'deadline': Timestamp.fromDate(roadmapItem.deadline),
    'isCompleted': roadmapItem.isCompleted,
    'createdAt': Timestamp.fromDate(roadmapItem.createdAt),
  }..remove('id');
}
