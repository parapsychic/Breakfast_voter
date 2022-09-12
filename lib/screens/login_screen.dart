import 'package:breakfast_voter/screens/signup_screen.dart';
import 'package:breakfast_voter/screens/voting_screen.dart';
import 'package:breakfast_voter/services/auth_service.dart';
import 'package:breakfast_voter/widgets/show_snackbar.dart';
import 'package:breakfast_voter/widgets/textfieldinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  loginUser() async {
    setState(() {
      _loading = true;
    });

    String res = await AuthService().loginUser(
      _emailEditingController.text,
      _passwordEditingController.text,
    );

    setState(() {
      _loading = false;
    });

    if (res == "success") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => VotingScreen()));
    } else {
      showSnackbar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFieldInput(
            textEditingController: _emailEditingController,
            hintText: "Enter email",
            textInputType: TextInputType.emailAddress),
        TextFieldInput(
          textEditingController: _passwordEditingController,
          hintText: "Password",
          textInputType: TextInputType.text,
          isPass: true,
        ),
        ElevatedButton(
            onPressed: () {
              loginUser();
            },
            child: _loading
                ? const CircularProgressIndicator()
                : const Text("Login")),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignupScreen()));
            },
            child: Text("Sign up now")),
      ],
    ));
  }
}
