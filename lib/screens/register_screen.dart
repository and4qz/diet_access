// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:diet_access/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/quickalert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool passenable = true;

  final fullnameController = TextEditingController();
  final idController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      FirebaseFirestore.instance.collection("users").add({
        "fullname": fullnameController.text,
        "student_id": idController.text,
        "email": emailController.text,
      });
      showAlertSukses();
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.message!);
    }
  }

  void showAlertSukses() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: "Registration Successful",
      backgroundColor: Color(0xff023341),
      titleColor: Color(0xfffbf4e2),
      textColor: Color(0xfffbf4e2),
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () {
        Navigator.pop(context);
        clearText();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LoginScreen(),
          ),
        );
      },
    );
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
        confirmBtnColor: Colors.red);
  }

  void clearText() {
    fullnameController.clear();
    idController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff023341),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              //Application Logo
              Image.asset(
                'assets/Letter-Logo-Icon.png',
                height: 250,
                width: 250,
              ),
              SizedBox(height: 50),

              //Fullname Textfield
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Theme(
                  data: ThemeData().copyWith(
                      colorScheme: ThemeData()
                          .colorScheme
                          .copyWith(primary: Color(0xfffd5e02))),
                  child: TextField(
                    controller: fullnameController,
                    style: TextStyle(
                      color: Color(0xff023341),
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
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
                      hintText: 'Fullname',
                      filled: true,
                      fillColor: Color(0xfffbf4e2),
                    ),
                  ),
                ),
              ),

              //StudentID Textfield
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Theme(
                  data: ThemeData().copyWith(
                      colorScheme: ThemeData()
                          .colorScheme
                          .copyWith(primary: Color(0xfffd5e02))),
                  child: TextField(
                    controller: idController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: TextStyle(
                      color: Color(0xff023341),
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.badge),
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
                      hintText: 'Student ID',
                      filled: true,
                      fillColor: Color(0xfffbf4e2),
                    ),
                  ),
                ),
              ),

              //Email Textfield
              SizedBox(height: 10),
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

              //Password Textfield
              SizedBox(height: 10),
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

              //Signup Button
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: signUp,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xfffd5e02),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Color(0xfffbf4e2),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),

              //Already have an account?
              SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xfffbf4e2),
                  ),
                ),
                GestureDetector(
                  onTap: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  }),
                  child: Text(
                    ' Login Now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xfffd5e02),
                    ),
                  ),
                )
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
