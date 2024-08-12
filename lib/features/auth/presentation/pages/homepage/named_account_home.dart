import 'package:flutter/material.dart';

class Named extends StatelessWidget {
  const Named({super.key});

  @override
  Widget build(BuildContext context) {
    final widthApp = MediaQuery.of(context).size.width;
    final heightApp = MediaQuery.of(context).size.height;
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: widthApp * 0.07),
            child: Text("WELCOME BACK FARHAN", style: TextStyle(fontSize: widthApp * 0.09, color: Colors.white),),
          ),
        ],
      );
    });
  }
}
