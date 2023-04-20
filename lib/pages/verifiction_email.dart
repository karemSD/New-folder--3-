import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googleauth/pages/home_page.dart';
import 'package:googleauth/services/auth_service.dart';

class VerifiedEmail extends StatefulWidget {
  const VerifiedEmail({super.key});
  static bool isEmailVerified = false;
  @override
  State<VerifiedEmail> createState() => _VerifiedEmailState();
}

class _VerifiedEmailState extends State<VerifiedEmail> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    VerifiedEmail.isEmailVerified =
        AuthService.firebaseAuth.currentUser!.emailVerified;
    if (!VerifiedEmail.isEmailVerified) {
      // AuthService().sendVerifiectionEmail();
      timer = Timer.periodic(const Duration(seconds: 15), ((timer) async {
        await AuthService().checkEmailVerifction();
        print("==========");
        setState(() {
          VerifiedEmail.isEmailVerified;
          if (VerifiedEmail.isEmailVerified) {
            cancelTimer();
          }
        });
      }));
    }
  }

  cancelTimer() {
    timer?.cancel();
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  test() async {
    await FirebaseAuth.instance.currentUser!.reload();
    bool res = FirebaseAuth.instance.currentUser!.emailVerified;
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return VerifiedEmail.isEmailVerified
        ? HomePage()
        : SafeArea(
            child: Scaffold(
            appBar: AppBar(
              title: const Text("verified Email"),
              centerTitle: true,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${VerifiedEmail.isEmailVerified}",
                    style: const TextStyle(fontSize: 30),
                  )
                ],
              ),
            ),
          ));
  }
}
