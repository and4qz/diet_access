// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, unused_import, no_leading_underscores_for_local_identifiers

import 'package:cart_stepper/cart_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_access/navigatorKey.dart';
import 'package:diet_access/screens/qr_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class KeranjangBelanja extends StatefulWidget {
  const KeranjangBelanja({super.key});

  @override
  State<KeranjangBelanja> createState() => _KeranjangBelanjaState();
}

class _KeranjangBelanjaState extends State<KeranjangBelanja> {
  @override
  Widget build(BuildContext context) {
    var cart = FlutterCart();
    num totalPrice = 0;

    Widget buildKeranjang(String nama, num harga, String cartId) {
      var _jumlah = cart.getSpecificItemFromCart(cartId)!.quantity;
      var itemIndex = cart.findItemIndexFromCart(cartId);
      var _totalPrice = harga * _jumlah;
      totalPrice += _totalPrice;

      var padding2 = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xfffbf4e2),
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nama,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Text("Rp" + harga.toString(),
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 14)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          cart.decrementItemFromCart(itemIndex!);
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xfffd5e02),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: Icon(Icons.remove)),
                    SizedBox(width: 10),
                    Text(
                      _jumlah.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        cart.incrementItemToCart(itemIndex!);
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xfffd5e02),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      return padding2;
    }

    return Scaffold(
      backgroundColor: Color(0xff023341),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Keranjang Belanja'),
        backgroundColor: Color(0xff023341),
        actions: [],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: cart.cartItem
                  .map((e) =>
                      buildKeranjang(e.productName!, e.unitPrice, e.productId))
                  .toList(),
            ),
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Color(0xfffd5e02),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xfffbf4e2),
                        ),
                      ),
                      Text(
                        "Rp " + totalPrice.toString(),
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xfffbf4e2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                navigatorKey?.currentState
                    ?.push(MaterialPageRoute(builder: (_) => QRCode()));
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xfffbf4e2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Generate QR Code',
                    style: TextStyle(
                        color: Color(0xfffd5e02),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
