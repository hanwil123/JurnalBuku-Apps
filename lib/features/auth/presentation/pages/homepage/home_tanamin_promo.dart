import 'package:flutter/material.dart';
import 'package:jurnalbukuapps/Api/FetchBooksApi.dart';
import 'package:jurnalbukuapps/Model/Books.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/daftarbuku/buku_detail_page.dart';

class HomeTanaminPromo extends StatefulWidget {
  final double heightBody;

  HomeTanaminPromo({Key? key, required this.heightBody}) : super(key: key);

  @override
  _HomeTanaminPromoState createState() => _HomeTanaminPromoState();
}

class _HomeTanaminPromoState extends State<HomeTanaminPromo> {
  late Future<List<Book>> futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.heightBody * 0.5, // Use half of the available height
      child: FutureBuilder<List<Book>>(
        future: futureBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No books available'));
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final book = snapshot.data![index];
                return UncontainedLayoutCard(
                  index: index,
                  coverImage: book.coverImage,
                  judul: book.judul,
                  penulis: book.penulis,
                  sinopsis: book.sinopsis,
                  halaman: book.halaman,
                  pdfUrl: book.pdfUrl,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class UncontainedLayoutCard extends StatelessWidget {
  const UncontainedLayoutCard({
    Key? key,
    required this.index,
    required this.coverImage,
    required this.judul,
    required this.penulis,
    required this.sinopsis,
    required this.halaman,
    required this.pdfUrl
  }) : super(key: key);

  final int index;
  final String coverImage;
  final String judul;
  final String penulis;
  final String sinopsis;
  final int halaman;
  final String pdfUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the BookDetailPage when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(
              coverImage: coverImage,
              judul: judul,
              penulis: penulis,
              sinopsis: sinopsis,
              halaman: halaman,
              pdfUrl: pdfUrl
            ),
          ),
        );
      },
      child: Container(
        color: Colors.black,
        width: 200, // Fixed width for each card
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  coverImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    print('Error loading image: $error');
                    return Container(
                      color: Colors.grey,
                      child: Icon(Icons.error),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    penulis,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}