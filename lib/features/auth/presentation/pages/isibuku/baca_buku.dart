import 'package:flutter/material.dart';
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
  final PagingController<int, String> _pagingController =
      PagingController(firstPageKey: 1);
  late PageController _pageController;
  int _currentPage = 1;
  int _totalPages = 0;
  Map<int, String> _pageCache = {};
  int _preloadDistance = 2;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _loadPdfContent();
  }

  Future<void> _loadPdfContent() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode == 200) {
        _document = PdfDocument(inputBytes: response.bodyBytes);
        setState(() {
          _totalPages = _document.pages.count;
        });
        _pagingController.refresh();
        _preloadPages(_currentPage);
      } else {
        throw Exception('Failed to load PDF');
      }
    } catch (e) {
      print('Error loading PDF: $e');
      _pagingController.error = 'Failed to load PDF content';
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      if (pageKey > _totalPages) {
        _pagingController.appendLastPage([]);
        return;
      }

      String pageContent = await _getPageContent(pageKey);
      final newItems = [pageContent];

      final isLastPage = pageKey == _totalPages;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        _pagingController.appendPage(newItems, pageKey + 1);
      }

      _preloadPages(pageKey);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<String> _getPageContent(int pageKey) async {
    if (_pageCache.containsKey(pageKey)) {
      return _pageCache[pageKey]!;
    }

    final content = PdfTextExtractor(_document).extractText(
      startPageIndex: pageKey - 1,
      endPageIndex: pageKey - 1,
    );
    _pageCache[pageKey] = content;
    return content;
  }

  void _preloadPages(int currentPage) {
    for (int i = 1; i <= _preloadDistance; i++) {
      int nextPage = currentPage + i;
      int prevPage = currentPage - i;
      if (nextPage <= _totalPages) {
        _getPageContent(nextPage);
      }
      if (prevPage > 0) {
        _getPageContent(prevPage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baca Buku - Halaman $_currentPage dari $_totalPages'),
      ),
      body: Stack(
        children: [
          PagedPageView<int, String>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<String>(
              itemBuilder: (context, item, index) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(item),
                ),
              ),
              firstPageProgressIndicatorBuilder: (context) =>
                  Center(child: CircularProgressIndicator()), // Loading saat halaman pertama
              newPageProgressIndicatorBuilder: (context) =>
                  Center(child: CircularProgressIndicator()), // Loading saat halaman berikutnya
            ),
            onPageChanged: (index) {
              setState(() {
                _currentPage = index + 1;
              });
              _preloadPages(_currentPage);
            },
          ),
          if (_totalPages == 0)
            Center(child: CircularProgressIndicator()), // Loading saat data PDF sedang dimuat
        ],
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
