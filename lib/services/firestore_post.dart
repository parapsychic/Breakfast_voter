import 'package:breakfast_voter/core/date_formatter.dart';
import 'package:breakfast_voter/models/post/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirestorePost {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Upload
  Future<String> uploadNewPost({required String foodName}) async {
    String res = "Something went wrong";

    try {
      final postUid = const Uuid().v1();
      final date = DateFormatter.getDateNow();

      foodName = foodName.trim();

      final list = await _firestore
          .collection("posts")
          .doc(date)
          .collection(date)
          .where("foodName", isEqualTo: foodName)
          .get();
      print("DUPE CHECK: $list");
      if (list.docs.isNotEmpty) {
        res = "Already posted";
        return res;
      }

      Post post = Post(
          postID: postUid,
          foodName: foodName,
          opUid: _auth.currentUser!.uid,
          upvotes: 0,
          date: date);

      await _firestore
          .collection("posts")
          .doc(date)
          .collection(date)
          .doc(postUid)
          .set(post.toJson());

      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // Get
  Future<List<Post?>> getTodaysPosts() async {
    List<Post> list = [];
    try {
      final date = DateFormatter.getDateNow();

      final snap =
          await _firestore.collection("posts").doc(date).collection(date).get();

      for (var post in snap.docs) {
        print("Casting list");
        list.add(Post.fromJson(post.data()));
      }
    } catch (e) {
      print(e.toString());
    }

    return list;
  }

  Future<String> updatePost(String uid) async {
    String res = "Something went wrong";
    try {
      final date = DateFormatter.getDateNow();

      final snap = await _firestore
          .collection("posts")
          .doc(date)
          .collection(date)
          .doc(uid)
          .get();

      final post = Post.fromJson(snap.data()!);

      await _firestore
          .collection("posts")
          .doc(date)
          .collection(date)
          .doc(uid)
          .update({"upvotes": post.upvotes + 1});

      res = "success";
    } catch (e) {
      print(e.toString());
    }

    return res;
  }

  Future<Post?> getWinningPost() async {
    Post? post;
    final list = await getTodaysPosts();

    if (list.isNotEmpty) {
      if (list.length == 1) {
        return list[0];
      }
      list.sort(((a, b) => a!.upvotes.compareTo(b!.upvotes)));
      post = list[0];
    }
    return post;
  }
}
