import 'package:flutter/material.dart';

class ListBooks extends StatefulWidget {
  const ListBooks({super.key});

  @override
  _ListBooksState createState() => _ListBooksState();
}

class _ListBooksState extends State<ListBooks> {
  final jsonArray = [
    {"text": "All Categories", "value": 1, "status": true},
    {"text": "Comedy", "value": 2, "status": false},
    {"text": "Romance", "value": 3, "status": false},
    {"text": "Fiction", "value": 4, "status": false},
    {"text": "Biografi", "value": 5, "status": false},
    {"text": "Slice of Life", "value": 6, "status": false}
  ];

  @override
  void initState() {
    super.initState();
    // Any additional initialization can be done here
    _loadCategories();
  }

  void _loadCategories() {
    // Here, you could reload or fetch the categories if needed
    setState(() {
      // Trigger a rebuild with the updated data
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthApp = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Center(
          child: Container(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 42),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: jsonArray.length,
                itemBuilder: (context, index) {
                  final item = jsonArray[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: UncontainedLayoutCard(
                      index: item['value'] as int,
                      label: item['text'] as String,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class UncontainedLayoutCard extends StatelessWidget {
  const UncontainedLayoutCard({
    super.key,
    required this.index,
    required this.label,
  });

  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
