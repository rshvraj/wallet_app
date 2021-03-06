import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app/Pages/LoginPage.dart';
import 'package:wallet_app/pages/welcomePage.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const MyHomePage(
              title: "Wallet",
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something Went wrong!"),
            );
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
