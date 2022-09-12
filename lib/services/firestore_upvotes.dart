import 'package:breakfast_voter/core/date_formatter.dart';
import 'package:breakfast_voter/models/upvote/upvote.dart';
import 'package:breakfast_voter/services/firestore_post.dart';
import 'package:breakfast_voter/widgets/show_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirestoreUpvotes {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestorePost _postMethods = FirestorePost();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> addUpvote(String postUid) async {
    String res = "Some error occured";
    try {
      final userUid = _auth.currentUser!.uid;
      final uid = const Uuid().v1();
      Upvote upvote = Upvote(uid: uid, userUid: userUid, postUid: postUid);

      final date = DateFormatter.getDateNow();

      final alreadyUpvoted = await _firestore
          .collection("upvotes")
          .doc(date)
          .collection(date)
          .where("userUid", isEqualTo: _auth.currentUser!.uid)
          .get();
      print(alreadyUpvoted.docs);
      if (alreadyUpvoted.docs.isNotEmpty) {
        res = "Upvotes exhausted";
        return res;
      }

      await _firestore
          .collection("upvotes")
          .doc(date)
          .collection(date)
          .doc(uid)
          .set(upvote.toJson());

      _postMethods.updatePost(postUid);
      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
