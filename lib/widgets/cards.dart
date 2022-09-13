import 'package:breakfast_voter/models/user/user.dart';
import 'package:breakfast_voter/services/firestore_upvotes.dart';
import 'package:breakfast_voter/services/firestore_user.dart';
import 'package:breakfast_voter/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/post/post.dart';

class FoodCard extends StatefulWidget {
  FoodCard({super.key, required this.post, this.winner = false});

  bool winner;
  Post post;

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  Color _iconColor = Colors.grey;
  String _user = "NAN";

  @override
  void initState() {
    super.initState();
    //getUser();
  }

//  getUser() async {
//    final user = await FirestoreUser().getUser(widget.post.opUid);
//    setState(() {
//      _user = user.name;
//    });
//  }

  upvoteFood() async {
    String res = await FirestoreUpvotes().addUpvote(widget.post.postID);

    if (res == "success") {
      setState(() {
        _iconColor = Colors.orange;
      });
    } else {
      showSnackbar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(widget.post.foodName),
      //subtitle: Text(_user),
      trailing: widget.winner
          ? Text(widget.post.upvotes.toString())
          : IconButton(
              icon: Icon(
                Icons.arrow_upward,
                color: _iconColor,
              ),
              onPressed: () => upvoteFood(),
            ),
    ));
  }
}
