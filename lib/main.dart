import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleauth/constants/app_constans.dart';
import 'package:googleauth/pages/login_page.dart';
import 'package:googleauth/pages/splashPage.dart';
import 'package:googleauth/settings/bindings/initial_bindings.dart';

import 'package:googleauth/utils/messages.dart';
import 'utils/dep.dart' as dep;
import 'controllers/languageController.dart';
import 'firebase_options.dart';
import 'utils/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  InitialBindings().dependencies();
  Map<String, Map<String, String>> _languages = await dep.init();
  runApp(MyApp(
    languages: _languages,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return GetMaterialApp(
        locale: localizationController.locale,
        initialRoute: SplashScreen.id,
        getPages: RouteHelper.routes,

        translations: Messages(languages: languages),
        fallbackLocale:
            Locale(AppConstants.languageCode[1], AppConstants.countryCode[1]),
        debugShowCheckedModeBanner: false,

        // defaultTransition:  Transition.topLevel,
      );
    });
  }
}
