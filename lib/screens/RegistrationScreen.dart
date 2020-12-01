import 'package:flutter/material.dart';
import 'package:flutterFirestore/screens/DashboardScreen.dart';
import 'package:flutterFirestore/screens/LoginScreen.dart';
import 'package:flutterFirestore/widgets/CustomTextFormField.dart';
import 'package:flutterFirestore/widgets/PasswordField.dart';
import 'package:flutterFirestore/widgets/PrimaryButton.dart';
import 'package:flutterFirestore/widgets/SecondaryButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ForgotPasswordScreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String routeName = "registration";
  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      labelText: "First Name",
                      hintText:
                          "First Name must have a minimum of 4 characters.",
                      iconData: FontAwesomeIcons.user,
                      controller: TextEditingController(),
                      onChange: null,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormField(
                      labelText: "Last Name",
                      hintText:
                          "First Name must have a minimum of 4 characters.",
                      iconData: FontAwesomeIcons.user,
                      controller: TextEditingController(),
                      onChange: null,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormField(
                      labelText: "Email",
                      hintText: "Enter a valid email.",
                      iconData: FontAwesomeIcons.solidEnvelope,
                      controller: TextEditingController(),
                      onChange: (value) {
                        email = value;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    PasswordField(
                      obscureText: _obscurePassword,
                      onTap: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      labelText: "Password",
                      hintText: "Enter your password",
                      controller: TextEditingController(),
                      onChange: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    PasswordField(
                      obscureText: _obscureConfirmPassword,
                      onTap: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      labelText: "Confirm Password",
                      hintText: "Your passwords must match.",
                      controller: TextEditingController(),
                      onChange: null,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    PrimaryButton(
                        text: "Register",
                        iconData: FontAwesomeIcons.solidFolder,
                        onPress: register),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SecondaryButton(
                            text: "Already have an account? Login",
                            onPress: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            }),
                        SecondaryButton(
                            text: "Forgot Password?",
                            onPress: () {
                              Navigator.pushNamed(
                                  context, ForgotPasswordScreen.routeName);
                            }),
                      ],
                    ),
                  ],
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register() async {
    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (newUser != null) {
        Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {}
  }
}
