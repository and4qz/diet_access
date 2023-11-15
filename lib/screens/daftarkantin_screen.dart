// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_access/navigatorKey.dart';
import 'package:diet_access/screens/daftarmakanan_screen.dart';
import 'package:diet_access/screens/template/kantin.dart';
import 'package:diet_access/screens/template/star.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DaftarKantin extends StatelessWidget {
  DaftarKantin({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  //Read Data Kantin dari Firestore
  Stream<List<Kantin>> readKantin() => FirebaseFirestore.instance
      .collection('kantin')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Kantin.fromJson(doc.data())).toList());

  getName(String click) async {
    final name = await FirebaseFirestore.instance
        .collection('kantin')
        .where('nama', isEqualTo: click)
        .get();
    return name;
  }

  //Card Kantin
  Widget buildKantin(Kantin kantin) => Padding(
        padding: const EdgeInsets.all(5),
        child: GestureDetector(
          onTap: (() {
            navigatorKey?.currentState?.push(MaterialPageRoute(
                builder: (_) => DaftarMakanan(namakantin: kantin.nama)));
          }),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Ink.image(
                  image: NetworkImage(kantin.gambar),
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
                          kantin.nama,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff023341),
                            fontSize: 32,
                          ),
                        ),
                        SizedBox(height: 8),
                        StarWidget(activated: kantin.bintang),
                        Divider(
                          color: Color(0xff023341),
                          height: 24,
                          thickness: 1,
                        ),
                        SizedBox(height: 8),
                        Text(
                          kantin.deskripsi,
                          style: TextStyle(
                            color: Color(0xff023341),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff023341),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff023341),
        actions: [
          IconButton(onPressed: signOut, icon: Icon(Icons.logout)),
          // IconButton(
          //     onPressed: (() {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (_) => DaftarMakanan()));
          //     }),
          //     icon: Icon(Icons.arrow_forward))

          // Add Food :D
          // IconButton(
          //     onPressed: (() {
          //       Navigator.push(
          //           context, MaterialPageRoute(builder: (_) => AddFood()));
          //     }),
          //     icon: Icon(Icons.add))
        ],
        title: Text(
          "Diet Access",
          style: TextStyle(color: Color(0xfffbf4e2)),
        ),
      ),

      //Daftar Kantin
      body: StreamBuilder<List<Kantin>>(
        stream: readKantin(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went Wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final kantin = snapshot.data!;
            return ListView(
              children: kantin.map(buildKantin).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
