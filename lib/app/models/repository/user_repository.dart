import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medica_app/app/models/user.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = 'users';

  // ✅ Save User Data to Firestore
  Future<void> saveUserData({required Users user}) async {
  try {
    await _firestore.collection(collectionPath).doc(user.id).set(user.toJson());
  } catch (e) {
    rethrow;
  }
}


  // ✅ Get User Data
  Future<Users?> getUser(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection(collectionPath).doc(userId).get();

      if (doc.exists) {
        return Users.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // ✅ Update User Data
  Future<void> updateUserData(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionPath).doc(userId).update(data);
    } catch (e) {
      rethrow;
    }
  }
}
