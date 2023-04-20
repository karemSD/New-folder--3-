import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as dev;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:googleauth/constants/constant.dart';
import 'package:googleauth/controllers/topController.dart';
import 'package:googleauth/controllers/userController.dart';
import 'package:googleauth/models/User/User_model.dart';
import 'package:googleauth/services/collectionsrefrences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleauth/pages/verifiction_email.dart';

typedef EitherException<T> = Future<Either<Exception, T>>;
Future<String> getFcmToken() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  return fcmToken!;
}

class AuthService {
  UserController userController = Get.put(UserController());

  static final firebaseAuth = FirebaseAuth.instance;
//? do you want to use this or the second one??
  EitherException<bool> updateEmail({required String email}) async {
    final user = firebaseAuth.currentUser;
    try {
      if (EmailValidator.validate(email)) {
        await user?.updateEmail(email);
        return const Right(true);
      }
    } on Exception catch (e) {
      return Left(e);
    }
    return Left(Exception("Please Enter Valid Email"));
  }
//? do you want to use this or the first  one?
//  Future<bool> updateEmail2({required String email}) async {
//     final user = firebaseAuth.currentUser;
//     if (EmailValidator.validate(email)) {
//       await user?.updateEmail(email);
//       return true;
//     }
//     return false;
//   }

  EitherException<bool> updatePassword({required String newPassword}) async {
    final user = firebaseAuth.currentUser;
    RegExp regExletters = RegExp(r"(?=.*[a-z])\w+");
    RegExp regExnumbers = RegExp(r"(?=.*[0-9])\w+");
    RegExp regExbigletters = RegExp(r"(?=.*[A-Z])\w+");

    try {
      if (regExletters.hasMatch(newPassword) == false ||
          regExnumbers.hasMatch(newPassword) == false ||
          regExbigletters.hasMatch(newPassword) == false) {
        return Left(Exception(
            "Please the password should  contian at least 8 characters and Big letters and small  with one number at least"));
      }
      await user?.updatePassword(newPassword);
      return const Right(true);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  EitherException<bool> createUserWithEmailAndPassword(
      {required String email,
      required password,
      required UserModel userModel}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await userController.createUser(userModel: userModel);
      return const Right(true);
    } on Exception catch (e) {
      return Left(e);
    }
    // authFormType = AuthFormType.signUpWithotVerifiedEmail;
  }

  EitherException<bool> sendVerifiectionEmail() async {
    final user = firebaseAuth.currentUser;
    try {
      if (!user!.emailVerified) {
        await user.sendEmailVerification();
        return const Right(true);
      }
      return const Right(true);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<void> checkEmailVerifction() async {
    //Call after send email verifiction
    try {
      await firebaseAuth.currentUser!.reload();
      print("reload");
      if (firebaseAuth.currentUser!.emailVerified) {
        VerifiedEmail.isEmailVerified = true;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> sigInWithEmailAndPassword({
    required String email,
    required String password,
    /* required void Function({required String id}) function */
  }) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

// just now for tesr

//
    await updatFcmToken();

    //authFormType = AuthFormType.email;
  }

  Future<void> updatFcmToken(/*{required String id}*/) async {
    dev.log("message");

    userController.updateUser(data: {
      tokenFcmK: FieldValue.arrayUnion([await getFcmToken()]),
    }, id: firebaseAuth.currentUser!.uid);
    dev.log("message");
  }

  //* it works
  EitherException<UserCredential> signInWithFacebook(
      /* {required void Function() updateFcmToken}
     */
      ) async {
    try {
      var facebookAuthCredential = await getFacebookCredential();
      // Once signed in, return the UserCredential

      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(facebookAuthCredential);
      await noUserMakeOne(userCredential: userCredential);
      await updatFcmToken();
      //  authFormType = AuthFormType.facbook;
      return Right(userCredential);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  noUserMakeOne({required UserCredential userCredential}) async {
    dev.log("check not here");
    TopController topController = TopController();
    if (!(await topController.existByOne(
        collectionReference: usersRef,
        value: userCredential.user?.uid,
        field: idK))) {
      dev.log("not here");
      UserModel userModel = UserModel(
          emailParameter: userCredential.user!.email,
          nameParameter: userCredential.user!.displayName!,
          imageUrlParameter: userCredential.user!.photoURL!,
          idParameter: userCredential.user!.uid,
          createdAtParameter: DateTime.now(),
          updatedAtParameter: DateTime.now());
      await userController.createUser(userModel: userModel);
      dev.log("not here");
    }
  }

  Future<OAuthCredential> getFacebookCredential() async {
// Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]);

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    return facebookAuthCredential;
  }

  //* it works
  AuthCredential getEmailCredential(
      {required String email, required String password}) {
    // Email and password sign-in
    final AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    return credential;
  }

  //* it works
  Future<OAuthCredential> getGooglecredential() async {
    //Trigger the authentication
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();
//Obtin the auth detailes from request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
//Create New Credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return credential;
  }

  Future<void> convertAnonymousToFacebook() async {
    OAuthCredential oAuthCredential = await getFacebookCredential();
    await convertAnonymousToPermanent(credential: oAuthCredential);
  }

  //* it works
  Future<void> convertAnonymousToGoogle() async {
    OAuthCredential credential = await getGooglecredential();
    await convertAnonymousToPermanent(
      credential: credential,
      //authFormTypeParameter: AuthFormType.google
    );
  }

  //* it works
  Future<void> convertAnonymousToEmailandPassword(
      {required String email, required String password}) async {
    final credential = getEmailCredential(email: email, password: password);
    await convertAnonymousToPermanent(
      credential: credential,
      // authFormTypeParameter: AuthFormType.email
    );
  }

  //* it works
  Future<void> convertAnonymousToPermanent({
    required credential,
    // required AuthFormType authFormTypeParameter
  }) async {
    try {
      final userCredential =
          await firebaseAuth.currentUser?.linkWithCredential(credential);
      await updatFcmToken();
      //authFormType = authFormTypeParameter;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          if (kDebugMode) {
            print("The provider has already been linked to the user.");
          }
          break;
        case "invalid-credential":
          if (kDebugMode) {
            print("The provider's credential is not valid.");
          }
          break;
        case "credential-already-in-use":
          if (kDebugMode) {
            print("The account corresponding to the credential already exists, "
                "or is already linked to a Firebase User.");
          }
          break;
        // See the API reference for the full list of error codes.
        default:
          if (kDebugMode) {
            print("Unknown error.");
          }
      }
    }
  }

  //* it works
  EitherException<UserCredential> signInWithGoogle(
      /*  {required void Function() updateFcmToken}
    */
      ) async {
    try {
      final credential = await getGooglecredential();
      //when sign in ,return the UserCredential
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      await noUserMakeOne(userCredential: userCredential);
      await updatFcmToken();
      return Right(userCredential);
    } on Exception catch (e) {
      return Left(e);
    }
    //authFormType = AuthFormType.google;
  }

  //* it works
  EitherException<UserCredential> anonymosSignInMethod() async {
    try {
      final credential = await firebaseAuth.signInAnonymously();
      return Right(credential);
    } on Exception catch (e) {
      return Left(e);
    }
    //  authFormType = AuthFormType.anonymous;
  }

  //* it works
  Future<void> logOut() async {
    dev.log("remove");
    await userController.updateUser(data: {
      tokenFcmK: FieldValue.arrayRemove([await getFcmToken()]),
    }, id: firebaseAuth.currentUser!.uid);
    await firebaseAuth.signOut();
    //authFormType = AuthFormType.nothing;
    dev.log("remove");
  }
}

/*

الميثود تبع التوكين أخي 
وقت بدك تسجل دخول بحساب لازم تحفظ التوكن كمان احتياطاً شوف إذا الاي دي موجود أو لا تبع الفاير بيس اوث اذا مانو موجود سوي حساب 
  void signInUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: userEmailController.text, password: passwordController.text);
    userController.updateUser(data: {
      "tokenFcm": FieldValue.arrayUnion([await getFcmToken()]),
    }, id: userCredential.user!.uid);
    Navigator.pop(context);
  }
وقت بدك تسجل حساب أخي لازم تحفظ التوكين 
void signUpUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (confirmPasswordController.text == passwordController.text) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: userEmailController.text,
                password: passwordController.text)
            .then((value) async {
          String token = await getFcmToken();
          UserModel userModel = UserModel(
              nameParameter: "sung jin woo",
              imageUrlParameter:
                  "https://i.pinimg.com/originals/7e/29/17/7e29176ed998ad8d35cd1813dee93a7f.jpg",
              tokenFcm: [token],
              idParameter: value.user!.uid,
              createdAtParameter: DateTime.now(),
              updatedAtParameter: DateTime.now());
          await userController.createUser(userModel: userModel);
          return value;
        });
      } else {
        errorMessage('password and confirm password not the same');
      }
      Get.back();
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);

      if (ex.code == 'user-not-found') {
        errorMessage('Wrong Email');
      }

      if (ex.code == 'wrong-password') {
        errorMessage('Wrong password');
      } else {
        errorMessage(ex.code);
      }
    }
  }
ووقت بتعمل signout 
IconButton(
            onPressed: () async {
              userController.updateUser(data: {
                "tokenFcm": FieldValue.arrayRemove([await getFcmToken()]),
              }, id: firebaseAuth.currentUser!.uid);
              await firebaseAuth.signOut();
            },
            icon: Icon(Icons.logout))

*/
