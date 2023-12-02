import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoalItemDatasource {
  GoalItemDatasource(this._firestore, this._auth);
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Future<QuerySnapshot> retrieveGoalItems() {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('goals')
        .get();
  }

  Future<DocumentReference> createGoalItem(Map<String, dynamic> goalItem) {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('goals')
        .add(goalItem);
  }

  Future<void> updateGoalItem(String id, Map<String, dynamic> goalItem) {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('goals')
        .doc(id)
        .update(goalItem);
  }

  Future<void> deleteGoalItem(String goalItemId) {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('goals')
        .doc(goalItemId)
        .delete();
  }
}
