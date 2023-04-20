import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googleauth/constants/constant.dart';
import 'package:googleauth/controllers/userController.dart';
import 'package:googleauth/pages/home_page.dart';
import 'package:googleauth/pages/rigster_page.dart';
import 'package:googleauth/pages/verifiction_email.dart';
import 'dart:developer' as dev;
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/sqaure_Button.dart';
import '../models/User/User_model.dart';
import '../services/auth_service.dart';
import '../services/collectionsrefrences.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserController userController = Get.put(UserController());
  final userEmailController = TextEditingController();
  // AuthFormType authFormType = AuthFormType.nothing;
  final passwordController = TextEditingController();

  void signInUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // authFormType = AuthFormType.email;
    // await AuthService().sendVerifiectionEmail();
  }

  void errorMessage(String message) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              '$message ❌',
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // logo App
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SizedBox(
                    width: 250,
                    child: Image.asset('assets/images/KAREM.jpg'),
                  ),
                ),

                //say Hi
                Text(
                  'Nice to see You!',
                  style: GoogleFonts.pacifico(fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Email field
                MyTextFiled(
                  obscureText: false,
                  controller: userEmailController,
                  hinText: 'Email',
                  inputType: TextInputType.emailAddress,
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                // password field

                MyTextFiled(
                  obscureText: true,
                  controller: passwordController,
                  hinText: 'Password',
                  inputType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(
                    Icons.key,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                //forget Password

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 5,
                ),
                //Login button

                MyButton(
                  onTap: () async {
                    // UserModel userModel = UserModel(
                    //   nameParameter: 'John Smith',
                    //   userNameParameter: 'john_smith_123',
                    //   imageUrlParameter: 'https://example.com/profile.jpg',
                    //   emailParameter: 'john.smith@example.com',
                    //   bio: 'A software developer',
                    //   idParameter: 'bHTiqnZURAdGCwnSuxj8GR3liu53',
                    //   createdAtParameter: DateTime.now(),
                    //   updatedAtParameter: DateTime.now(),
                    // );
                    // await userController.createUser(userModel: userModel);
                    // dev.log("done");

                    await AuthService().sigInWithEmailAndPassword(
                      email: userEmailController.text,
                      password: passwordController.text,
                    );

                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return HomePage();
                    })));
                  },
                  buttonText: 'Sign In',
                  color: Colors.deepPurpleAccent,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Or Continue With'),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                // Google icon Sign in

                // not registered make am account
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SquareButtonIcon(
                        imagePath: 'assets/images/google.png',
                        onTap: () async {
                          await AuthService().signInWithGoogle();
                          Get.off(HomePage());
                        }),
                    SquareButtonIcon(
                        imagePath: 'assets/images/facebook.png',
                        onTap: () {
                          AuthService().signInWithFacebook();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => HomePage())));
                        }),
                    SquareButtonIcon(
                        imagePath: 'assets/images/anonymos.png',
                        onTap: () async {
                          await AuthService().anonymosSignInMethod();
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => HomePage())));
                        }),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // not registered make am account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account? '),
                    GestureDetector(
                      //onTap: widget.onTap,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) {
                              return RigsterPage(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: ((context) {
                                    return const LoginPage();
                                  })));
                                },
                              );
                            }),
                          ),
                        );
                      },
                      child: const Text(
                        'Make One!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
