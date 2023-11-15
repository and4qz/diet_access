// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_access/screens/daftarkantin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class QRCode extends StatelessWidget {
  const QRCode({super.key});

  @override
  Widget build(BuildContext context) {
    var cart = FlutterCart();

    var listText = "";

    toText() {
      cart.cartItem.join(" ").toString();
    }

    return Scaffold(
      backgroundColor: Color(0xff023341),
      appBar: AppBar(
        centerTitle: true,
        title: Text('QR Code'),
        backgroundColor: Color(0xff023341),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/Letter-Logo.png",
                ),
              ),
              // Column(
              //   children: [

              //     Text(
              //       "QR Code",
              //       style: TextStyle(
              //           fontSize: 32,
              //           fontWeight: FontWeight.bold,
              //           color: Color(0xfffbf4e2)),
              //     ),
              //     Text(
              //       "Silahkan Scan QR Code Berikut di Kantin",
              //       style: TextStyle(
              //           color: Color(0xfffbf4e2),
              //           fontStyle: FontStyle.italic,
              //           fontSize: 16),
              //     )
              //   ],
              // ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xfffbf4e2),
                      borderRadius: BorderRadius.circular(12)),
                  // child: QrImage(
                  //   data: cart.cartItem.join(" "),
                  //   embeddedImage: AssetImage('assets/no-bg.png'),
                  // ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      text: "Terima Kasih telah Menggunakan Aplikasi Kami ",
                      backgroundColor: Color(0xff023341),
                      titleColor: Color(0xfffbf4e2),
                      textColor: Color(0xfffbf4e2),
                      confirmBtnColor: Colors.green,
                      onConfirmBtnTap: () {
                        Navigator.pop(context);
                        cart.deleteAllCart();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DaftarKantin(),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xfffd5e02),
                    ),
                    child: Center(
                      child: Text(
                        'Selesai',
                        style: TextStyle(
                            color: Color(0xfffbf4e2),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
