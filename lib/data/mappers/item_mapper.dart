import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roadmap/domain/entities/item_model.dart';

Item fromDocument(DocumentSnapshot doc) {
  final data = doc.data()! as Map<String, dynamic>;
  return Item.fromJson(data).copyWith(id: doc.id);
}

Map<String, dynamic> toDocument(Item item) {
  return item.toJson()..remove('id');
}
