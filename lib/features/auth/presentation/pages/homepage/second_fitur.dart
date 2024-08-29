import 'package:flutter/material.dart';
import 'package:jurnalbukuapps/Api/FetchCategoriesApi.dart';
import 'package:jurnalbukuapps/Model/Category.dart';

class SecondFitur extends StatefulWidget {
  const SecondFitur({super.key});

  @override
  State<SecondFitur> createState() => _SecondFiturState();
}

class _SecondFiturState extends State<SecondFitur> {
    late Future<List<Categories>> futureCategories;

    @override
    void initState() {
      super.initState();
      futureCategories = fetchCategories();
    }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      child: FutureBuilder<List<Categories>>(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No categories available'));
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final category = snapshot.data![index];
                return UncontainedLayoutCard(
                  category: category.name,
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
    required this.category,
  }) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120, // Fixed width for each item
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          category,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
