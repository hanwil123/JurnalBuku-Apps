import 'package:flutter/material.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/daftarbuku/buku_detail_page.dart';

class HomeTanaminPromo extends StatelessWidget {
  final double heightBody;

  HomeTanaminPromo({Key? key, required this.heightBody}) : super(key: key);

  final List<Map<String, dynamic>> bookData = [
    {
      "image": "assets/homebooklist/chairilanwar.jpg",
      "judulbuku": "Chairil Anwar",
      "penulis": "Bambang"
    },
    {
      "image": "assets/homebooklist/hpdeadlyhallows.jpg",
      "judulbuku": "Harry Potter And The Deadly Hallows",
      "penulis": "J.K Rowling"
    },
    {
      "image": "assets/homebooklist/negeri5menara.jpg",
      "judulbuku": "Negeri 5 Menara",
      "penulis": "A. Fuadi"
    },
    {
      "image": "assets/homebooklist/wintertokyo.jpg",
      "judulbuku": "Winter in Tokyo",
      "penulis": "Llana Tan"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightBody * 0.5, // Use half of the available height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: bookData.length,
        itemBuilder: (context, index) {
          final item = bookData[index];
          return UncontainedLayoutCard(
            index: index,
            judulbuku: item['judulbuku'],
            penulis: item['penulis'],
            imagePath: item['image'],
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
    required this.judulbuku,
    required this.penulis,
    required this.imagePath,
  }) : super(key: key);

  final int index;
  final String judulbuku;
  final String penulis;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: () {
        // Navigate to the BookDetailPage when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(
              imagePath: imagePath,
              judulbuku: judulbuku,
              penulis: penulis,
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
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
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
                    judulbuku,
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