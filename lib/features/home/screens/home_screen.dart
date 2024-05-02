import 'package:flutter/material.dart';

import 'package:rush/common/image_slider.dart';
import 'package:rush/features/offer/screens/myoffer_screen.dart';
import 'package:rush/utils/colors.dart';
import 'package:rush/utils/navigation.dart';
import 'package:rush/utils/sizes.dart';

import '../scr/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    statusBarColorChange(AppColor.statusBarColor);
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.backgroundColor,
          key: scaffoldKey,
          drawer: const Drawer(),
          appBar: AppBar(
            backgroundColor: AppColor.appbarColor,
            leading: InkWell(
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
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
                const SearchBarItem(),
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
          )),
    );
  }
}

class MensFashionScreen extends StatelessWidget {
  const MensFashionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    statusBarColorChange(AppColor.statusBarColor);
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.backgroundColor,
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: AppColor.appbarColor,
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
                const SearchBarItem(),
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
          )),
    );
  }
}

class GrabDealCard extends StatelessWidget {
  final String src, time;
  const GrabDealCard({
    super.key,
    required this.src,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Card(
            shadowColor: Colors.white,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 1,
            child: Container(
              height: 130,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    src,
                    height: 94,
                    width: 120,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            time,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                            child: Text(
                          'GRAB DEAL',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 20,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                  child: Text(
                '60% off',
                style: TextStyle(color: Colors.white, fontSize: 12),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class ViewAll extends StatelessWidget {
  const ViewAll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Row(
        children: [
          const Text(
            "EXTRA CASHBACK OFFERS FOR YOU",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: const Row(
              children: [
                Text(
                  "VIEW ALL",
                  style: TextStyle(color: Color(0xff0D2949), fontSize: 13),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Color(0xff0D2949),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HomeProdPage extends StatelessWidget {
  const HomeProdPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProdItem(
              text: "Men's Fashion",
              src: "assets/images/mensFashion.png",
              onTap: () {
                navigationPush(context, const MensFashionScreen());
              },
            ),
            ProdItem(
              text: "Ladies Fashion",
              src: "assets/images/womensfashion.png",
              onTap: () {},
            ),
            ProdItem(
              text: "Kids Wear",
              src: "assets/images/kidsfashion.png",
              onTap: () {},
            ),
            ProdItem(
              text: "Accessories",
              src: "assets/images/accessories.png",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class ProdItem extends StatelessWidget {
  final String text;
  final Function()? onTap;

  final String src;
  const ProdItem(
      {super.key, required this.text, required this.src, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              children: [
                InkWell(
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  onTap: onTap,
                  child: Container(
                    height: 60,
                    width: 80,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(src))),
                  ),
                ),
                Text(text, style: const TextStyle(fontSize: 11))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
