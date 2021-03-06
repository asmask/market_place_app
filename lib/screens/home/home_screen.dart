import 'package:flutter/material.dart';
import 'package:market_place_app/components/coustom_bottom_nav_bar.dart';
import 'package:market_place_app/screens/home/components/body.dart';

import '../../enums.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
