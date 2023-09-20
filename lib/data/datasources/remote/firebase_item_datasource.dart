import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roadmap/domain/entities/item_model.dart';

class FirebaseItemDataSource {
  FirebaseItemDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  Future<QuerySnapshot> retrieveItems() async {
    return _firestore.collection('lists').get();
  }

  Future<DocumentReference> createItem(Item item) async {
    return _firestore.collection('lists').add(item.toDocument());
  }

  Future<void> updateItem(Item item) async {
    await _firestore.collection('lists').doc(item.id).update(item.toDocument());
  }

  Future<void> deleteItem(String id) async {
    await _firestore.collection('lists').doc(id).delete();
  }
}
