// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/quickalert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<AddFood> {
  bool passenable = true;

  final makananController = TextEditingController();
  final hargaController = TextEditingController();
  final kantinController = TextEditingController();
  final gambarController = TextEditingController();

  void addFood() async {
    try {
      FirebaseFirestore.instance.collection("makanan").add({
        "makanan": makananController.text,
        "harga": int.parse(hargaController.text),
        "kantin": kantinController.text,
        "gambar": "https://drive.google.com/uc?export=view&id=" +
            gambarController.text,
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
    makananController.clear();
    hargaController.clear();
    kantinController.clear();
    gambarController.clear();
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
                    controller: makananController,
                    style: TextStyle(
                      color: Color(0xff023341),
                    ),
                    decoration: InputDecoration(
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
                      hintText: 'Makanan',
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
                    controller: hargaController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: TextStyle(
                      color: Color(0xff023341),
                    ),
                    decoration: InputDecoration(
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
                      hintText: 'Harga',
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
                    controller: kantinController,
                    style: TextStyle(
                      color: Color(0xff023341),
                    ),
                    decoration: InputDecoration(
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
                      hintText: 'Kantin',
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
                    controller: gambarController,
                    style: TextStyle(
                      color: Color(0xff023341),
                    ),
                    decoration: InputDecoration(
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
                      hintText: 'Gambar',
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
                  onTap: addFood,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xfffd5e02),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Add Food',
                        style: TextStyle(
                            color: Color(0xfffbf4e2),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
