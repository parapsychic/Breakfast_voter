import 'package:breakfast_voter/bloc/bloc/counter_bloc.dart';
import 'package:breakfast_voter/core/date_formatter.dart';
import 'package:breakfast_voter/models/post/post.dart';
import 'package:breakfast_voter/services/firestore_post.dart';
import 'package:breakfast_voter/widgets/cards.dart';
import 'package:breakfast_voter/widgets/countdown.dart';
import 'package:breakfast_voter/widgets/show_snackbar.dart';
import 'package:breakfast_voter/widgets/textfieldinput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  final _newEditingController = TextEditingController();
  List<Post> _posts = [];
  bool _uploading = false;
  String date = DateFormatter.getDateNow();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  addNewItem() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add a new item:"),
        content: TextFieldInput(
          hintText: "Food item",
          textEditingController: _newEditingController,
          textInputType: TextInputType.text,
        ),
        actions: [
          FloatingActionButton(
            onPressed: () async {
              if (_newEditingController.text.isEmpty) {
                showSnackbar(
                    context, "You gotta eat something! Type something.");
                return;
              }
              String res;
              setState(() {
                _uploading = true;
              });

              res = await FirestorePost()
                  .uploadNewPost(foodName: _newEditingController.text);

              setState(() {
                _uploading = false;
              });

              if (res == "success") {
                _newEditingController.text = "";
                Navigator.pop(context);
              } else {
                showSnackbar(context, res);
              }
            },
            child: _uploading ? CircularProgressIndicator() : Icon(Icons.done),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _newEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "What would you like to eat today?",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 20,
                ),
                CountdownTimer(), // also displays results after time ends

                SizedBox(
                  height: 30,
                ),
                BlocBuilder<CounterBloc, CounterState>(
                  builder: (context, state) {
                    if (state is CounterCompleted) {
                      return Text(
                        "Happy Dining 🥗",
                        style: TextStyle(fontSize: 15),
                      );
                    }
                    return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("posts")
                            .doc(date)
                            .collection(date)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.docs.isEmpty) {
                              return Center(child: Text("So empty here..."));
                            }

                            return Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot<Map<String, dynamic>> ds =
                                        snapshot.data!.docs[index];
                                    return FoodCard(
                                        post: Post.fromJson(ds.data()!));
                                  }),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        });
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: () => addNewItem()),
      ),
    );
  }
}
