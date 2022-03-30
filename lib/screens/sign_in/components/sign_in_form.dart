import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:market_place_app/components/custom_surfix_icon.dart';
import 'package:market_place_app/components/form_error.dart';
import 'package:market_place_app/helper/keyboard.dart';
import 'package:market_place_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:market_place_app/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool? remember = false;
  bool isLoading = false;

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
            ))
          : Column(
              children: [
                buildEmailFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                Row(
                  children: [
                    Checkbox(
                      value: remember,
                      activeColor: kPrimaryColor,
                      onChanged: (value) {
                        setState(() {
                          remember = value;
                        });
                      },
                    ),
                    const Text("Remember me"),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, ForgotPasswordScreen.routeName),
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(20)),
                DefaultButton(
                  text: "Continue",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      debugPrint(username);
                      debugPrint(password);
                      if (signIn(username!, password!)) {
                        // if all are valid then go to success screen
                        KeyboardUtil.hideKeyboard(context);
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      }
                    }
                  },
                ),
              ],
            ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Username",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Enter your username",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  signIn(String username, String pwd) async {
    isLoading = true;
    var url = Uri.parse("http://127.0.0.1:8000/api/login");
    Map data = {'username': username, 'password': pwd};
    // ignore: prefer_typing_uninitialized_variables
    //var jsonData;
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.post(url, body: json.encode(data), headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      //final jsonData = response.body;
      debugPrint(jsonData['token']);
      setState(() {
        isLoading = false;
        // To decode the token
        Map<String, dynamic> payload = Jwt.parseJwt(jsonData['token']);
        // Print the payload
        debugPrint(payload['username']);

        /*UserSimplePreferences.setUsername(jsonData['username']);
        UserSimplePreferences.setEmail(jsonData['email']);
        UserSimplePreferences.setId(jsonData['id']);
        UserSimplePreferences.setIsLoing(true);*/
        //sharedPreferences.setString("token", jsonData['accessToken']);
        SnackBar snackBar = const SnackBar(
          content: Text("Welcome !"),
          backgroundColor: kPrimaryColor,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //sharedPreferences.setString("email", jsonData['email']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const HomeScreen()),
            (Route<dynamic> route) => false);
      });
    } else {
      SnackBar snackBar = SnackBar(
        content: Text("Username : $username or password inccorrect !"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      debugPrint(response.body);
    }
  }
}
