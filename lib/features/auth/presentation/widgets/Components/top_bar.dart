import 'package:flutter/material.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/homepage/homePage_view.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final widthApp = MediaQuery.of(context).size.width;
    final heightApp = MediaQuery.of(context).size.height;
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      toolbarHeight: 60,
      leading: IconButton(
        color: Colors.white,
        icon: Image.asset(
          'assets/novelnestlogo.jpg', // Path to your image asset
          width: widthApp * 0.08, // Set width and height according to your needs
          height: heightApp * 0.08, // Set
          fit: BoxFit.cover, // Adjust the fit if needed
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePageView()));
        },
      ),
      actions: [
        IconButton(
          color: Colors.white,
          icon: Icon(Icons.account_circle_outlined),
          onPressed: () {
            // Your action here
          },
        ),
      ],
    );
  }
}
