import 'package:farmfusion/Routes/routes_name.dart';
import 'package:farmfusion/Screens/forgetpassword_screen.dart';
import 'package:farmfusion/Screens/registration_screen.dart';
import 'package:farmfusion/Screens/splash_screen.dart';
import 'package:get/get.dart';

import '../Screens/home_screen.dart';
import '../Screens/login_screen.dart';

class AppRoutes{

  static appRoutes() => [

    GetPage(
      name: RoutesName.splashScreen,
      page: () => SplashScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: RoutesName.homeScreen,
      page: () => HomeScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: RoutesName.registrationScreen,
      page: () => registrationScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: RoutesName.loginScreen,
      page: () => LoginScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: RoutesName.forgetPasswordScreen,
      page: () => forgetPasswordScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade,
    ),
  ];

}