import 'package:flutter/material.dart';
import 'package:market_place_app/routes.dart';
import 'package:market_place_app/screens/introduction_animation/introduction_animation_screen.dart';
import 'package:market_place_app/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Market place',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: IntroductionAnimationScreen.routeName,
      routes: routes,
    );
  }
}
