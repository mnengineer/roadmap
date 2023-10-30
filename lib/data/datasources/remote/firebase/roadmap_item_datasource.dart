import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoadmapItemDatasource {
  RoadmapItemDatasource(this._firestore, this._auth);
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Future<QuerySnapshot> retrieveRoadmapItems(String goalItemId) {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('goals')
        .doc(goalItemId)
        .collection('roadmap')
        .get();
  }

  Future<DocumentReference> createRoadmapItem(
    String goalItemId,
    Map<String, dynamic> roadmapItem,
  ) {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('goals')
        .doc(goalItemId)
        .collection('roadmap')
        .add(roadmapItem);
  }

  Future<void> updateRoadmapItem(
    String goalItemId,
    String roadmapItemId,
    Map<String, dynamic> roadmapItem,
  ) {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('goals')
        .doc(goalItemId)
        .collection('roadmap')
        .doc(roadmapItemId)
        .update(roadmapItem);
  }

  Future<void> deleteRoadmapItem(String goalItemId, String roadmapItemId) {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('goals')
        .doc(goalItemId)
        .collection('roadmap')
        .doc(roadmapItemId)
        .delete();
  }
}
