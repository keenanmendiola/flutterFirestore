import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterFirestore/screens/DashboardScreen.dart';
import 'package:flutterFirestore/screens/ForgotPasswordScreen.dart';
import 'package:flutterFirestore/screens/RegistrationScreen.dart';
import 'package:flutterFirestore/widgets/SecondaryButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/CustomTextFormField.dart';
import '../widgets/PasswordField.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "login";
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  bool _obscureText = true;
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
                      obscureText: _obscureText,
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
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
                    PrimaryButton(
                        text: "Login",
                        iconData: FontAwesomeIcons.doorOpen,
                        onPress: login),
                    SizedBox(
                      height: 20.0,
                    ),
                    PrimaryButton(
                        text: "Sign-in with Google",
                        iconData: FontAwesomeIcons.google,
                        onPress: () {
                          //authenticate here
                          Navigator.pushReplacementNamed(
                              context, DashboardScreen.routeName);
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SecondaryButton(
                            text: "New User? Register",
                            onPress: () {
                              Navigator.pushReplacementNamed(
                                  context, RegistrationScreen.routeName);
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

  void login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (user != null) {
        Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }
}
