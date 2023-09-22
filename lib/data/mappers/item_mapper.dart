import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roadmap/domain/entities/item.dart';

Item fromDocument(DocumentSnapshot doc) {
  final data = doc.data()! as Map<String, dynamic>;
  return Item(
    id: doc.id,
    title: data['title'] as String,
    isCompleted: data['isCompleted'] as bool,
    createdAt: (data['createdAt'] as Timestamp).toDate(),
  );
}

Map<String, dynamic> toDocument(Item item) {
  return {
    'id': item.id,
    'title': item.title,
    'isCompleted': item.isCompleted,
    'createdAt': Timestamp.fromDate(item.createdAt),
  }..remove('id');
}
