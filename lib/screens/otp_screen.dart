import 'package:breakfast_voter/screens/voting_screen.dart';
import 'package:breakfast_voter/widgets/show_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({super.key, required this.phone});
  String phone;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String? encryptedmessage;

  @override
  void initState() {
    super.initState();
    _sendOTP();
  }

  _sendOTP() async {
    try {
      var response =
          await Dio().get('http://192.168.158.205:8000/otp/${widget.phone}');
      setState(() {
        encryptedmessage = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  _completedOTP(String pin) {
    int actualpin = int.parse(pin);
    int encrypt = int.parse(encryptedmessage!);
    int decrypt = encrypt - actualpin;
    if (decrypt == 2000) {
      Navigator.pop(context, "OK");
    } else {
      showSnackbar(context, "Incorrect Pin");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Pinput(
          length: 6,
          hapticFeedbackType: HapticFeedbackType.heavyImpact,
          onCompleted: (pin) => _completedOTP(pin),
        ),
      ),
    );
  }
}
