import 'package:flutter/material.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/daftarbuku/daftarBuku_view.dart';

class BottomBar extends StatelessWidget implements PreferredSizeWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.book),
            onPressed: () {
              // Implement book action here
              Navigator.push(context, MaterialPageRoute(builder: (context) => DaftarbukuView()));
            },
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.add),
            onPressed: () {
              // Implement add action here
            },
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search action here
            },
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.menu),
            onPressed: () {
              // Implement menu action here
            },
          ),
        ],
      ),
    );
  }
}
