import 'package:flutter/material.dart';
import 'package:market_place_app/screens/sign_in/sign_in_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'HOME ',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.logout_rounded),
                onPressed: () => {
                      Navigator.of(this.context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const SignInScreen()),
                          (route) => false),
                    }),
          ]),
    );
  }
}
