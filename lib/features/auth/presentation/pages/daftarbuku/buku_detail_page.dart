import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jurnalbukuapps/features/auth/presentation/pages/isibuku/baca_buku.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class BookDetailPage extends StatefulWidget {
  final String coverImage;
  final String judul;
  final String penulis;
  final String sinopsis;
  final int halaman;
  final String pdfUrl;

  const BookDetailPage(
      {Key? key,
      required this.coverImage,
      required this.judul,
      required this.penulis,
      required this.sinopsis,
      required this.halaman,
      required this.pdfUrl})
      : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  String _pdfText = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadPdfContent() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode == 200) {
        final PdfDocument document =
            PdfDocument(inputBytes: response.bodyBytes);
        final String text = PdfTextExtractor(document).extractText();
        setState(() {
          _pdfText = text;
          _isLoading = false;
        });
        document.dispose();
      } else {
        throw Exception('Failed to load PDF');
      }
    } catch (e) {
      print('Error loading PDF: $e');
      setState(() {
        _pdfText = 'Error loading PDF content';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final widthApp = MediaQuery.of(context).size.width;
    final heightApp = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.judul),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.coverImage,
                      fit: BoxFit.cover,
                      height: heightApp * 0.4,
                      width: widthApp * 0.6,
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
                SizedBox(
                  height: 16,
                ),
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          widget.judul,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'by ${widget.penulis}',
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    child: Column(
                                  children: [
                                    Text(
                                      "4.4",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      "Rating",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                )),
                                Container(
                                    child: Column(
                                  children: [
                                    Text(
                                      "${widget.halaman}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      "Total Halaman",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                )),
                                Container(
                                    child: Column(
                                  children: [
                                    Text(
                                      "2h30m",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      "Audio",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                )),
                                Container(
                                    child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.bookmark)),
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Sinopsis',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            widget.sinopsis,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Isi Buku',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BacaBuku(
                                        pdfUrl: widget.pdfUrl,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  child: Row(children: [
                                    Icon(Icons.book),
                                    Text("Baca Buku")
                                  ]),
                                ))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
