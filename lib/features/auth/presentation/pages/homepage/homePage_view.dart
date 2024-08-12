import 'package:flutter/material.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/homepage/card_layout.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/homepage/named_account_home.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/homepage/second_fitur.dart';
import 'package:jurnalbukuapps/features/auth/presentation/widgets/Components/bottom_bar.dart';
import 'package:jurnalbukuapps/features/auth/presentation/widgets/Components/top_bar.dart';
import 'home_tanamin_promo.dart';
class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
 @override
  Widget build(BuildContext context) {
    
    final widthApp = MediaQuery.of(context).size.width;
    final heightApp = MediaQuery.of(context).size.height;
    final paddingTop = MediaQuery.of(context).padding.top;

    final appBar = TopBar();
    final botBar = BottomBar();

    final heightBody = heightApp - paddingTop - appBar.preferredSize.height - botBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Named(),
              SizedBox(height: 19),
              CardLayouts(heightBody: heightBody,),
              SizedBox(height: 19),
              SecondFitur(),
              SizedBox(height: 19),
              HomeTanaminPromo(heightBody: heightBody),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
