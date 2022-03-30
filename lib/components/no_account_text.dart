import 'package:flutter/material.dart';
import 'package:market_place_app/screens/sign_in/sign_in_screen.dart';

import '../constants.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignInScreen.routeName),
          child: const Text(
            "Login",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
