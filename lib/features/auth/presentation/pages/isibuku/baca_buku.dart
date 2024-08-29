import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BacaBuku extends StatefulWidget {
  final String pdfUrl;

  const BacaBuku({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  _BacaBukuState createState() => _BacaBukuState();
}

class _BacaBukuState extends State<BacaBuku> {
  late PdfDocument _document;
  late PageController _pageController;
  final PagingController<int, List<String>> _pagingController =
      PagingController(firstPageKey: 1);
  int _currentPage = 1;
  int _totalPages = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pagingController.addPageRequestListener(_fetchPage);
    _loadPdfContent();
  }

  Future<void> _loadPdfContent() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode == 200) {
        _document = PdfDocument(inputBytes: response.bodyBytes);
        setState(() {
          _totalPages = _document.pages.count;
          _isLoading = false;
        });
        _pagingController.refresh();
      } else {
        throw Exception('Failed to load PDF');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _pagingController.error = 'Failed to load PDF content';
    }
  }

Future<void> _fetchPage(int pageKey) async {
  try {
    if (pageKey > _totalPages) {
      _pagingController.appendLastPage([]);
      return;
    }

    // Memproses 2 halaman sekaligus untuk meringankan overhead
    int chunkSize = 2;
    int startPageIndex = pageKey - 1;
    int endPageIndex = (pageKey + chunkSize - 1).clamp(1, _totalPages);

    // Mengubah pageContents menjadi List<List<String>>
    List<List<String>> pageContents = await compute(_extractPageText, {
      'document': _document,
      'startPageIndex': startPageIndex,
      'endPageIndex': endPageIndex,
    });

    final isLastPage = endPageIndex == _totalPages;
    if (isLastPage) {
      _pagingController.appendLastPage(pageContents);
    } else {
      _pagingController.appendPage(pageContents, endPageIndex + 1);
    }
  } catch (error) {
    _pagingController.error = error;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baca Buku - Halaman $_currentPage dari $_totalPages'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : PagedPageView<int, List<String>>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<List<String>>(
                itemBuilder: (context, item, index) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: item.map((pageText) => Text(pageText)).toList(),
                    ),
                  ),
                ),
                firstPageErrorIndicatorBuilder: (context) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error first loading PDF content'),
                      ElevatedButton(
                        onPressed: () {
                          _pagingController.refresh();
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                ),
                newPageErrorIndicatorBuilder: (context) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error nlew oading PDF content'),
                      ElevatedButton(
                        onPressed: () {
                          _pagingController.retryLastFailedRequest();
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                ),
                firstPageProgressIndicatorBuilder: (context) =>
                    Center(child: CircularProgressIndicator()),
                newPageProgressIndicatorBuilder: (context) =>
                    Center(child: CircularProgressIndicator()),
                noItemsFoundIndicatorBuilder: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
              onPageChanged: (index) =>
                  setState(() => _currentPage = index + 1),
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _currentPage > 1
                  ? () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  : null,
            ),
            Text('Halaman $_currentPage dari $_totalPages'),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: _currentPage < _totalPages
                  ? () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _pageController.dispose();
    _document.dispose();
    super.dispose();
  }
}

// Fungsi untuk ekstraksi teks di isolate terpisah dengan chunk
Future<List<List<String>>> _extractPageText(Map<String, dynamic> params) async {
  final PdfDocument document = params['document'];
  final int startPageIndex = params['startPageIndex'];
  final int endPageIndex = params['endPageIndex'];

  List<List<String>> pageContents = [];
  for (int i = startPageIndex; i <= endPageIndex; i++) {
    String pageText = PdfTextExtractor(document).extractText(
      startPageIndex: i,
      endPageIndex: i,
    );
    // Tambahkan hasil ekstraksi sebagai elemen list
    pageContents.add([pageText]);
  }
  return pageContents;
}
