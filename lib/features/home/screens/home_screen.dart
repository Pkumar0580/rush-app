import 'package:flutter/material.dart';
import 'package:rush/common/image_slider.dart';
import 'package:rush/utils/colors.dart';
import 'package:rush/utils/sizes.dart';
import '../scr/drawer.dart';
import '../scr/home_screen_scr.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        key: drawerKey,
        drawer: const Drawer(
          child: CusDrawer(),
        ),
        appBar: AppBar(
          backgroundColor: AppColor.appbarColor,
          leading: InkWell(
            onTap: () {
              drawerKey.currentState?.openDrawer();
            },
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              child: Image.asset("assets/images/hamburger-icon.png"),
            ),
          ),
          title: const Text(
            "RUSH",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ImageSlide(),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 25),
                child: Text("Top categories", style: TextStyle(fontSize: 16)),
              ),
              const HomeProdPage(),
              heightSizedBox(5.0),
              const ViewAll(),
              heightSizedBox(5.0),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GrabDealCard(
                      src: 'assets/images/calvinklein.png',
                      time: '02:14:27',
                    ),
                    GrabDealCard(
                      src: 'assets/images/tommy.png',
                      time: '02:14:27',
                    ),
                    GrabDealCard(
                      src: 'assets/images/calvinklein.png',
                      time: '02:14:27',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  "assets/images/Rectangle21.png",
                  fit: BoxFit.cover,
                  width: width(context),
                ),
              )
            ],
          ),
        ));
  }
}
