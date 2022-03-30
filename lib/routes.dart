import 'package:flutter/widgets.dart';
import 'package:market_place_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:market_place_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:market_place_app/screens/home/home_screen.dart';
import 'package:market_place_app/screens/introduction_animation/introduction_animation_screen.dart';
import 'package:market_place_app/screens/sign_in/sign_in_screen.dart';
import 'package:market_place_app/screens/sign_up/sign_up_screen.dart';
import 'package:market_place_app/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  IntroductionAnimationScreen.routeName: (context) =>
      const IntroductionAnimationScreen(),
};
