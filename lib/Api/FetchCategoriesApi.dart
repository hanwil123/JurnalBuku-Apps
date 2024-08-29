import 'dart:convert';

import 'package:jurnalbukuapps/Model/Category.dart';
import 'package:http/http.dart' as http;

Future<List<Categories>> fetchCategories() async {
  try {
    final response = await http.get(
      Uri.parse('http://192.168.1.6:9000/api/categories'),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      print('Decoded JSON: $jsonResponse');
      
      return jsonResponse.map((data) => Categories.fromJson(data)).toList();
    } else {
      throw Exception('Gagal memuat kategori: ${response.statusCode}');
    }
  } catch (e) {
    print('Error saat mengambil kategori: $e');
    throw Exception('Gagal memuat kategori: $e');
  }
}
