import 'package:breakfast_voter/models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirestoreUser {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addNewUser(
      String uid, String name, String companyID, String phone) async {
    String res = "Something went wrong";
    try {
      User user =
          User(uid: uid, name: name, companyID: companyID, phone: phone);

      await _firestore.collection("users").doc(uid).set(user.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<User> getUser(
    String uid,
  ) async {
    User? user;
    try {
      final doc = await _firestore.collection("users").doc(uid).get();
      if (doc.data() != null) user = User.fromJson(doc.data()!);
      return user!;
    } catch (e) {
      User user = User(
          uid: "ERROR", name: e.toString(), companyID: "ERROR", phone: "ERROR");
    }
    return user!;
  }
}
