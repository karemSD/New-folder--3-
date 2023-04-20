import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleauth/constants/constant.dart';
import 'package:googleauth/services/auth_service.dart';

import 'login_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  Future<void> logOut() async {
    await AuthService().logOut();
    Get.off(const LoginPage());

    // authFormType = AuthFormType.nothing;
  }

  //final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        Padding(
          padding: const EdgeInsets.only(top: 22),
          child: GestureDetector(
            onTap: logOut,
            child: const Text(
              'LogOut',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        IconButton(onPressed: logOut, icon: const Icon(Icons.logout))
      ]),
      body: StreamBuilder<User?>(
          stream: AuthService.firebaseAuth.userChanges(),
          builder: (context, snapshot) {
            //AuthService.firebaseAuth.currentUser!.reload();
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "LOGGED IN!  ${snapshot.data!.email}}  ${snapshot.data!.emailVerified}",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: (() async {
                      await AuthService().convertAnonymousToGoogle();
                      print("done");
                    }),
                    child: const Text("sing with Google"),
                  )
                ],
              );
            }
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }),
    );
  }
}
