import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseItemDataSource {
  FirebaseItemDataSource(this._firestore);
  final FirebaseFirestore _firestore;

  Future<QuerySnapshot> retrieveItems() {
    return _firestore.collection('lists').get();
  }

  Future<DocumentReference> createItem(Map<String, dynamic> item) {
    return _firestore.collection('lists').add(item);
  }

  Future<void> updateItem(String id, Map<String, dynamic> item) {
    return _firestore.collection('lists').doc(id).update(item);
  }

  Future<void> deleteItem(String id) {
    return _firestore.collection('lists').doc(id).delete();
  }
}
