import 'package:flutter/material.dart';
import 'package:jurnalbukuapps/Api/FetchBooksApi.dart';
import 'package:jurnalbukuapps/Model/Books.dart';


class CardLayouts extends StatefulWidget {
  final double heightBody;

  const CardLayouts({Key? key, required this.heightBody}) : super(key: key);

  @override
  State<CardLayouts> createState() => _CardLayoutsState();
}

class _CardLayoutsState extends State<CardLayouts> {
  late Future<List<Book>> futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    final widthApp = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Center(
          child: Container(
            height: widget.heightBody * 0.3, // Use 30% of the available height
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
                  return CarouselView(
                    itemSnapping: true,
                    itemExtent: widthApp * 0.8, // Use 80% of the screen width
                    shrinkExtent: widthApp *
                        0.7, // Use 70% of the screen width for shrunk items
                    children: List<Widget>.generate(snapshot.data!.length,
                        (int index) {
                      return UncontainedLayoutCard(
                        index: index,
                        imagePath: snapshot.data![index].coverImage,
                      );
                    }),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class UncontainedLayoutCard extends StatelessWidget {
  const UncontainedLayoutCard({
    Key? key,
    required this.index,
    required this.imagePath,
  }) : super(key: key);

  final int index;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
