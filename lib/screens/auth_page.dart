// ignore_for_file: prefer_const_constructors

import 'package:diet_access/screens/daftarkantin_screen.dart';
import 'package:diet_access/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user login
          if (snapshot.hasData) {
            return DaftarKantin();
          }
          //user not login
          else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
