import 'package:flutter/material.dart';
import 'package:rush/features/home/screens/accessries.dart';
import 'package:rush/features/home/screens/kids_wear.dart';
import 'package:rush/features/home/screens/womens_fashion.dart';
import 'package:rush/features/offer/screens/offers_screen.dart';

import '../../../utils/navigation.dart';
import '../screens/mens_fashion.dart';

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
                navigationPush(context, const OffersScreen(initialTabIndex: 0));
              },
            ),
            ProdItem(
              text: "Ladies Fashion",
              src: "assets/images/womensfashion.png",
              onTap: () {
                navigationPush(context, const OffersScreen(initialTabIndex: 1));
              },
            ),
            ProdItem(
              text: "Kids Wear",
              src: "assets/images/kidsfashion.png",
              onTap: () {
                navigationPush(context, const OffersScreen(initialTabIndex: 2));
              },
            ),
            ProdItem(
              text: "Accessories",
              src: "assets/images/accessories.png",
              onTap: () {
                navigationPush(context, const OffersScreen(initialTabIndex: 3));
              },
            ),
          ],
        ),
      ),
    );
  }
}

// class GrabDealCard extends StatelessWidget {
//   final String src, time;
//   const GrabDealCard({
//     super.key,
//     required this.src,
//     required this.time,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Stack(
//         children: [
//           Card(
//             shadowColor: Colors.white,
//             color: Colors.white,
//             surfaceTintColor: Colors.white,
//             elevation: 1,
//             child: Container(
//               height: 130,
//               width: 140,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Colors.white,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Image.asset(
//                     src,
//                     height: 94,
//                     width: 120,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Column(
//                         children: [
//                           Text(
//                             time,
//                             style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         height: 20,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           color: Colors.orange,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Center(
//                             child: Text(
//                           'GRAB DEAL',
//                           style: TextStyle(color: Colors.white, fontSize: 10),
//                         )),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 0,
//             right: 0,
//             child: Container(
//               height: 20,
//               width: 60,
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Center(
//                   child: Text(
//                 '60% off',
//                 style: TextStyle(color: Colors.white, fontSize: 12),
//               )),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
