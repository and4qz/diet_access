import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String makanan;
  final String harga;
  final int jumlah;

  CartItem({
    required this.id,
    required this.makanan,
    required this.harga,
    required this.jumlah,
  });
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem({required String productId, harga, makanan}) {
    if (_items.containsKey(productId)) {
      //jumlah +=1
      _items.update(
          productId,
          (value) => CartItem(
                id: value.id,
                makanan: value.makanan,
                harga: value.harga,
                jumlah: value.jumlah + 1,
              ));
      notifyListeners();
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                makanan: makanan.toString(),
                harga: harga.toString(),
                jumlah: 1,
              ));
      notifyListeners();
    }
  }

  double get totalToPay {
    double total = 0.0;
    _items.forEach((key, value) {
      total += double.parse(value.harga) * value.jumlah;
    });
    return total;
  }
}
