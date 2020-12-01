import 'package:flutter/material.dart';
import 'package:flutterFirestore/screens/SettingsScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardScreen extends StatefulWidget {
  static String routeName = "dashboard";

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      email = loggedInUser.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SettingsScreen.routeName);
              },
              child: Icon(Icons.settings, size: 26.0),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text("$email"),
      ),
    );
  }
}
