import 'package:flutter/material.dart';

class SecondFitur extends StatelessWidget {
  SecondFitur({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> jsonArray = [
    {"text": "All Categories", "value": 1, "status": true},
    {"text": "Comedy", "value": 2, "status": false},
    {"text": "Romance", "value": 3, "status": false},
    {"text": "Fiction", "value": 4, "status": false},
    {"text": "Biografi", "value": 5, "status": false},
    {"text": "Slice of Life", "value": 6, "status": false}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: jsonArray.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final item = jsonArray[index];
          return UncontainedLayoutCard(
            index: item['value'] as int,
            label: item['text'] as String,
          );
        },
      ),
    );
  }
}

class UncontainedLayoutCard extends StatelessWidget {
  const UncontainedLayoutCard({
    Key? key,
    required this.index,
    required this.label,
  }) : super(key: key);

  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120, // Fixed width for each item
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}