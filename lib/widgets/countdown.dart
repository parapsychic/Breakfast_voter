import 'dart:async';

import 'package:breakfast_voter/bloc/bloc/counter_bloc.dart';
import 'package:breakfast_voter/core/date_formatter.dart';
import 'package:breakfast_voter/models/post/post.dart';
import 'package:breakfast_voter/services/firestore_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cards.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int _start = 10;
  late Timer _timer;
  bool _completed = false;
  Post? winnerPost = Post(
      postID: "postID",
      foodName: "foodName",
      opUid: "opUid",
      upvotes: 1,
      date: "date"); // initialized to not get initialization errs

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  updateWinner() async {
    final post = await FirestorePost().getWinningPost();
    setState(() {
      winnerPost = post;
    });
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  startTimer() {
    Duration duration = DateFormatter.timeTillEnd();
    if (duration.isNegative) {
      _completed = true;
      context.read<CounterBloc>().add(CounterCompletedEvent());
      updateWinner();
      return;
    }
    setState(() {
      _start = duration.inSeconds;
    });
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _completed = true;

            context.read<CounterBloc>().add(CounterCompletedEvent());
            updateWinner();
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _completed
        ? Column(
            children: [
              const Text(
                "Most Upvoted Post: ",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              if (winnerPost != null)
                FoodCard(
                  post: winnerPost!,
                  winner: true,
                )
              else
                const Text(
                  "No food listed",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
            ],
          )
        : Text("Time till voting ends:  ${format(Duration(seconds: _start))}");
  }
}
