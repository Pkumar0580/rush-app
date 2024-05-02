import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rush/utils/navigation.dart';
import 'package:rush/utils/sizes.dart';
import '../../../utils/colors.dart';
import '../../offer/screens/myoffer_screen.dart';

class MyBrandScreen extends StatefulWidget {
  const MyBrandScreen({super.key});

  @override
  State<MyBrandScreen> createState() => _MyBrandScreenState();
}

class _MyBrandScreenState extends State<MyBrandScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);
    statusBarColorChange(AppColor.statusBarColor);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColor.appbarColor,
          title: const Text("My Brand"),
          automaticallyImplyLeading: true,

          // leading: IconButton(
          //     onPressed: () {
          //       navigationPop(context);
          //     },
          //     icon: const Icon(Icons.arrow_back)),
        ),
        body: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xff204571),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30, bottom: 30.0, left: 10.0, right: 10.0),
                child: SizedBox(
                  height: 40,
                  child: CupertinoSearchTextField(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        //  backgroundColor: Colors.white,

                        borderRadius: BorderRadius.circular(21)),
                  ),
                ),
              ),
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
                children: const [
                  MyBrandTabScreen(),
                  MyBrandTabScreen(),
                  MyBrandTabScreen(),
                  MyBrandTabScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyBrandTabScreen extends StatelessWidget {
  const MyBrandTabScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BrendsLogoCard(src: 'assets/images/amazon-logo-s3f.png'),
                    BrendsLogoCard(src: 'assets/images/Flipkart-Logo.png'),
                  ],
                ),
                heightSizedBox(10.0)
              ],
            ),
          );
        });
  }
}

class CurvedSearchTextField extends StatelessWidget {
  const CurvedSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0), // Adjust the value as needed
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        color: Colors.grey[200], // Background color of the text field
        child: const Row(
          children: [
            Icon(Icons.search),
            SizedBox(width: 10.0), // Add spacing between icon and text field
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none, // Hide default border
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
