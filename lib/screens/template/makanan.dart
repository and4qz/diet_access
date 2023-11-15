// ignore_for_file: prefer_typing_uninitialized_variables

class Makanan {
  final id;
  final String makanan;
  final String kantin;
  final num harga;
  final String gambar;

  Makanan({
    required this.id,
    required this.makanan,
    required this.kantin,
    required this.harga,
    required this.gambar,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'makanan': makanan,
        'kantin': kantin,
        'harga': harga,
        'gambar': gambar,
      };

  static Makanan fromJson(Map<String, dynamic> json) => Makanan(
      id: json['id'],
      makanan: json['makanan'],
      kantin: json['kantin'],
      harga: json['harga'],
      gambar: json['gambar']);
}
