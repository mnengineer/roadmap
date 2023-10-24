import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseItemDataSource {
  FirebaseItemDataSource(this._firestore, this._auth);
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Future<QuerySnapshot> retrieveItems() {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('lists')
        .get();
  }

  Future<DocumentReference> createItem(Map<String, dynamic> item) {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('lists')
        .add(item);
  }

  Future<void> updateItem(String id, Map<String, dynamic> item) {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('lists')
        .doc(id)
        .update(item);
  }

  Future<void> deleteItem(String id) {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('lists')
        .doc(id)
        .delete();
  }
}
