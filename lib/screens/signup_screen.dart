import 'package:breakfast_voter/screens/otp_screen.dart';
import 'package:breakfast_voter/screens/voting_screen.dart';
import 'package:breakfast_voter/services/auth_service.dart';
import 'package:breakfast_voter/widgets/show_snackbar.dart';
import 'package:breakfast_voter/widgets/textfieldinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameEditingController = TextEditingController();
  final _emailEditingController = TextEditingController();
  final _passEditingController = TextEditingController();
  final _companyEditingController = TextEditingController();
  final _phoneEditingController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _nameEditingController.dispose();
    _emailEditingController.dispose();
    _passEditingController.dispose();
    _companyEditingController.dispose();
    _phoneEditingController.dispose();
    super.dispose();
  }

  signupUser() async {
    setState(() {
      _loading = true;
    });

    final status = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OTPScreen(phone: _phoneEditingController.text.trim()),
        ));

    if (status != "OK") {
      setState(() {
        _loading = false;
      });
      return;
    }

    String res = await AuthService().signupUser(
      _nameEditingController.text,
      _emailEditingController.text,
      _passEditingController.text,
      _companyEditingController.text,
      _phoneEditingController.text,
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
            textEditingController: _nameEditingController,
            hintText: "Name",
            textInputType: TextInputType.text),
        TextFieldInput(
            textEditingController: _companyEditingController,
            hintText: "Company ID",
            textInputType: TextInputType.text),
        TextFieldInput(
            textEditingController: _phoneEditingController,
            hintText: "Phone",
            textInputType: TextInputType.number),
        TextFieldInput(
            textEditingController: _emailEditingController,
            hintText: "Email",
            textInputType: TextInputType.emailAddress),
        TextFieldInput(
            textEditingController: _passEditingController,
            hintText: "Password",
            isPass: true,
            textInputType: TextInputType.text),
        ElevatedButton(onPressed: () => signupUser(), child: Text("Register"))
      ],
    ));
  }
}
