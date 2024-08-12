import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final String imagePath;
  final String judulbuku;
  final String penulis;

  const BookDetailPage({
    Key? key,
    required this.imagePath,
    required this.judulbuku,
    required this.penulis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final widthApp = MediaQuery.of(context).size.width;
    final heightApp = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(judulbuku),
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
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      height: heightApp * 0.4,
                      width: widthApp * 0.6
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          judulbuku,
                          style:
                              TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'by $penulis',
                          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
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
                                    Text("4.4", style: TextStyle(color: Colors.black),),
                                    Text("Rating", style: TextStyle(color: Colors.black),),
                                  ],
                                )),
                                Container(
                                    child: Column(
                                  children: [
                                    Text("200 Halaman", style: TextStyle(color: Colors.black),),
                                    Text("Total Halaman", style: TextStyle(color: Colors.black),),
                                  ],
                                )),
                                Container(
                                    child: Column(
                                  children: [
                                    Text("2h30m", style: TextStyle(color: Colors.black),),
                                    Text("Audio", style: TextStyle(color: Colors.black),),
                                  ],
                                )),
                                Container(
                                    child: Column(
                                  children: [
                                    IconButton(onPressed: () {}, icon: Icon(Icons.bookmark)),
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16,),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Sinopsis',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 16,),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
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
