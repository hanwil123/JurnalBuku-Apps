import 'package:flutter/material.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/homepage/homePage_view.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      toolbarHeight: 60,
      leading: IconButton(
        color: Colors.white,
        icon: Icon(Icons.format_list_bulleted_rounded),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePageView()));
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
