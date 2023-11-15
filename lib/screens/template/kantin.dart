class Kantin {
  String id;
  final String nama;
  final int bintang;
  final String deskripsi;
  final String gambar;

  Kantin({
    this.id = '',
    required this.nama,
    required this.bintang,
    required this.deskripsi,
    required this.gambar,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'bintang': bintang,
        'deskripsi': deskripsi,
        'gambar': gambar,
      };

  static Kantin fromJson(Map<String, dynamic> json) => Kantin(
      nama: json['nama'],
      bintang: json['bintang'],
      deskripsi: json['deskripsi'],
      gambar: json['gambar']);

  getName() {
    return nama;
  }
}
