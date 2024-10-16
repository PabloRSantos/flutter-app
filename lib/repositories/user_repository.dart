import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> create(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  Future<void> update(UserModel user) async {
    await _firestore.collection('users').doc(user.id).update(user.toMap());
  }

  Future<UserModel?> getUser(String id) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(id).get();

    if (documentSnapshot.exists) {
      return UserModel.fromMap(
          documentSnapshot.data() as Map<String, dynamic>, documentSnapshot.id);
    }
    return null;
  }
}
