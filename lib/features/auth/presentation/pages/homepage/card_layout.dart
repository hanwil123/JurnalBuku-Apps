import 'package:flutter/material.dart';

class CardLayouts extends StatefulWidget {
  final double heightBody;

  const CardLayouts({Key? key, required this.heightBody}) : super(key: key);

  @override
  State<CardLayouts> createState() => _CardLayoutsState();
}

class _CardLayoutsState extends State<CardLayouts> {
  final List<String> imageUrls = [
    "assets/homebooklist/chairilanwar.jpg",
    "assets/homebooklist/hpdeadlyhallows.jpg",
    "assets/homebooklist/negeri5menara.jpg",
    "assets/homebooklist/wintertokyo.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final widthApp = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Center(
          child: Container(
            height: widget.heightBody * 0.3, // Use 30% of the available height
            child: CarouselView(
              itemSnapping: true,
              itemExtent: widthApp * 0.8, // Use 80% of the screen width
              shrinkExtent: widthApp * 0.7, // Use 70% of the screen width for shrunk items
              children: List<Widget>.generate(imageUrls.length, (int index) {
                return UncontainedLayoutCard(
                  index: index,
                  imagePath: imageUrls[index],
                );
              }),
            ),
          ),
        );
      }
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
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
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