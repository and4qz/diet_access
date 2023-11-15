// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'dart:math';

import 'package:diet_access/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:quickalert/quickalert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passenable = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.message!);
    }
  }

  void showErrorMessage(String message) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: "Error",
      text: message,
      backgroundColor: Color(0xff023341),
      titleColor: Color(0xfffbf4e2),
      textColor: Color(0xfffbf4e2),
      confirmBtnColor: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff023341),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Logo
                Image.asset(
                  "assets/Letter-Logo-Icon.png",
                  height: 250,
                  width: 250,
                ),
                SizedBox(height: 50),
                //Email Textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Theme(
                    data: ThemeData().copyWith(
                        colorScheme: ThemeData()
                            .colorScheme
                            .copyWith(primary: Color(0xfffd5e02))),
                    child: TextField(
                      controller: emailController,
                      style: TextStyle(
                        color: Color(0xff023341),
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.alternate_email),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xfffbf4e2),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xfffd5e02),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Email',
                        filled: true,
                        fillColor: Color(0xfffbf4e2),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //Password Textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Theme(
                    data: ThemeData().copyWith(
                        colorScheme: ThemeData()
                            .colorScheme
                            .copyWith(primary: Color(0xfffd5e02))),
                    child: TextField(
                      controller: passwordController,
                      obscureText: passenable,
                      style: TextStyle(
                        color: Color(0xff023341),
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (passenable) {
                                passenable = false;
                              } else {
                                passenable = true;
                              }
                            });
                          },
                          icon: Icon(passenable == true
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xfffbf4e2),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xfffd5e02),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Password',
                        filled: true,
                        fillColor: Color(0xfffbf4e2),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //Login Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xfffd5e02),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              color: Color(0xfffbf4e2),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),

                //Dont have an account? Register Now!
                SizedBox(height: 30),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xfffbf4e2),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => RegisterScreen()));
                    },
                    child: Text(
                      ' Register Now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xfffd5e02),
                      ),
                    ),
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
