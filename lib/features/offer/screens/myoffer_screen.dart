import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rush/utils/sizes.dart';

import '../../../utils/colors.dart';

class MyOfferScreen extends StatefulWidget {
  const MyOfferScreen({super.key});

  @override
  State<MyOfferScreen> createState() => _MyOfferScreenState();
}

class _MyOfferScreenState extends State<MyOfferScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);
    statusBarColorChange(AppColor.statusBarColor);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.appbarColor,
          title: const Text(
            "Offers",
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: true,
        ),
        body: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xff204571)),
            ),
            TabBar(
              indicatorColor: const Color(0xff1F4570),
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: const TextStyle(
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              controller: tabController,
              tabs: const [
                Tab(text: 'Popular'),
                Tab(text: 'A-Z'),
                Tab(text: 'Percent'),
                Tab(text: 'Amount'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  PopularScreen(),
                  PopularScreen(),
                  PopularScreen(),
                  PopularScreen()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopularScreen extends StatelessWidget {
  const PopularScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            const AmazonCard(),
            heightSizedBox(10.0),
            const AmazonCard(),
            heightSizedBox(10.0),
            const AmazonCard(),
            heightSizedBox(10.0),
            const AmazonCard(),
          ],
        ),
      ),
    );
  }
}

class AmazonCard extends StatelessWidget {
  const AmazonCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Stack(
          children: [
            Card(
              // shadowColor: ColorsConst.cardColor,
              color: Colors.white,
              // surfaceTintColor: ColorsConst.cardColor,
              elevation: 1,
              child: Container(
                height: 140,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/amazon-logo-s3f.png',
                      height: 94,
                      width: 120,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Column(
                          children: [
                            Text(
                              'Expires in',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '02:14:27',
                              style: TextStyle(
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
        const BrendsLogoCard(
          src: 'assets/images/Flipkart-Logo.png',
        )
      ],
    );
  }
}

class BrendsLogoCard extends StatelessWidget {
  final String src;
  const BrendsLogoCard({
    super.key,
    required this.src,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // shadowColor: ColorsConst.cardColor,
      color: Colors.white,
      // surfaceTintColor: ColorsConst.cardColor,
      elevation: 1,
      child: Container(
        height: 127,
        width: 148,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Image.asset(
          src,
        ),
      ),
    );
  }
}
