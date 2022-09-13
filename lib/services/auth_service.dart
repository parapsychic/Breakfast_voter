import 'package:breakfast_voter/models/user/user.dart' as model;
import 'package:breakfast_voter/services/firestore_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signupUser(String name, String email, String password,
      String companyID, String phone) async {
    String res = "Some error occurred";

    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String uid = cred.user!.uid;
      FirestoreUser().addNewUser(uid, name, companyID, phone);
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser(
    String email,
    String password,
  ) async {
    String res = "Some error occurred";

    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      String uid = cred.user!.uid;
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
