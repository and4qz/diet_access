// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, must_be_immutable, use_key_in_widget_constructors, sort_child_properties_last

import 'package:diet_access/navigatorKey.dart';
import 'package:diet_access/screens/keranjang_belanja.dart';
import 'package:diet_access/screens/template/makanan.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cart/flutter_cart.dart';

class DaftarMakanan extends StatelessWidget {
  String namakantin;
  DaftarMakanan({required this.namakantin});

  var cart = FlutterCart();

  //Read Data Makanan dari Firestore
  Stream<List<Makanan>> readMakanan() => FirebaseFirestore.instance
      .collection('makanan')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Makanan.fromJson(doc.data())).toList());

  //Card Makanan
  Widget buildMakanan(Makanan makanan) {
    if (makanan.kantin == namakantin) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Ink.image(
                image: NetworkImage(makanan.gambar),
                height: 240,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Color(0xfffbf4e2)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        makanan.makanan,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff023341),
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rp " + makanan.harga.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff023341),
                              fontSize: 24,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (cart.getSpecificItemFromCart(makanan.id) !=
                                  null) {
                                cart
                                    .getSpecificItemFromCart(makanan.id)!
                                    .quantity++;
                              } else {
                                cart.addToCart(
                                  productId: makanan.id,
                                  productName: makanan.makanan,
                                  unitPrice: makanan.harga,
                                );
                              }
                            },
                            child: Text(
                              "Tambahkan",
                              style: TextStyle(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xfffd5e02),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff023341),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff023341),
        actions: [
          IconButton(
              onPressed: (() {
                navigatorKey?.currentState?.push(
                    MaterialPageRoute(builder: (_) => KeranjangBelanja()));
              }),
              icon: Icon(Icons.shopping_bag))
        ],
        title: Text(
          "Diet Access",
          style: TextStyle(
            color: Color(0xfffbf4e2),
          ),
        ),
      ),
      body: StreamBuilder<List<Makanan>>(
        stream: readMakanan(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went Wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final makanan = snapshot.data!;
            return ListView(
              children: makanan.map(buildMakanan).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
