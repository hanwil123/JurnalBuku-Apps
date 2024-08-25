class Book {
  final String coverImage;
  final String judul;
  final String penulis;
  final String sinopsis;
  final int halaman;
  final double rating;
  final String pdfUrl;
  final String? audioLength;

  Book({
    required this.coverImage,
    required this.judul,
    required this.penulis,
    required this.sinopsis,
    required this.halaman,
    required this.rating,
    required this.pdfUrl,
    this.audioLength,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    const baseUrl =
        'http://192.168.1.6:9000/storage/'; // Base URL untuk file di public
    // Base URL untuk file di public
    return Book(
      coverImage: baseUrl + (json['cover_image'] ?? ''),
      judul: json['judul'] ?? '',
      penulis: json['penulis'] ?? '',
      sinopsis: json['sinopsis'] ?? '',
      halaman: json['halaman'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      audioLength: json['audio_length'],
      pdfUrl: baseUrl + (json['isibuku'] ?? ''),
    );
  }
}
