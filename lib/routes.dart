import 'package:flutter/material.dart';
import 'package:flutterFirestore/screens/DashboardScreen.dart';
import 'package:flutterFirestore/screens/ForgotPasswordScreen.dart';
import 'package:flutterFirestore/screens/LoginScreen.dart';
import 'package:flutterFirestore/screens/RegistrationScreen.dart';
import 'package:flutterFirestore/screens/SettingsScreen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (BuildContext context) => LoginScreen(),
  RegistrationScreen.routeName: (BuildContext context) => RegistrationScreen(),
  ForgotPasswordScreen.routeName: (BuildContext context) =>
      ForgotPasswordScreen(),
  DashboardScreen.routeName: (BuildContext context) => DashboardScreen(),
  SettingsScreen.routeName: (BuildContext context) => SettingsScreen(),
};
