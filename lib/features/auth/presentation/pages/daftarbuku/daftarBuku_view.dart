import 'package:flutter/material.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/daftarbuku/daftar_buku_list.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/homepage/card_layout.dart';
import 'package:jurnalbukuapps/features/auth/presentation/widgets/Components/list_book.dart';
import 'package:jurnalbukuapps/features/auth/presentation/widgets/Components/searchbar.dart';
import 'package:jurnalbukuapps/features/auth/presentation/widgets/Components/bottom_bar.dart';

class DaftarbukuView extends StatefulWidget {
  const DaftarbukuView({super.key});

  @override
  State<DaftarbukuView> createState() => _DaftarbukuViewState();
}

class _DaftarbukuViewState extends State<DaftarbukuView> {
  @override
  Widget build(BuildContext context) {
    final widthApp = MediaQuery.of(context).size.width;
    final heightApp = MediaQuery.of(context).size.height;
        final heightBody = heightApp;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      width: widthApp * 1,
                      child: SearchBarApp(),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: widthApp * 0.07),
                child: ListBooks()
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: widthApp * 0.02),
                child: DaftarBukuLists(heightBody: heightBody)
              )
            ],
          ),
        )),
        bottomNavigationBar: BottomBar());
  }
}

