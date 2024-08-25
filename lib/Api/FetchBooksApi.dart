import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jurnalbukuapps/Model/Books.dart';

Future<List<Book>> fetchBooks() async {
  try {
    final response = await http.get(
      Uri.parse('http://192.168.1.6:9000/api/books'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List booksData = jsonResponse['data'];

      return booksData.map((data) => Book.fromJson(data)).toList();
    } else {
      throw Exception('Gagal memuat buku: ${response.statusCode}');
    }
  } catch (e) {
    print('Error saat mengambil buku: $e');
    throw Exception('Gagal memuat buku: $e');
  }
}
