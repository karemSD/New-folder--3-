import 'package:get/get.dart';
import 'package:googleauth/pages/languageScreen.dart';
import 'package:googleauth/pages/splashPage.dart';

class RouteHelper{
  
  static List<GetPage> routes = [

    GetPage(name: SplashScreen.id, page: () {
      return const SplashScreen();
    }),
    // GetPage(name: initial, page:(){
    //   return HomePage();
    // }),
    GetPage(name: LanguagePage.id, page:(){
      return const LanguagePage();
    })
  ];
}