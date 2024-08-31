import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rush/features/offer/repo/offers_repo.dart';
import 'package:rush/features/offer/screens/offer_detail_screen.dart';
import 'package:rush/utils/navigation.dart';
import 'package:rush/utils/secure_storage%20copy.dart';
import 'package:rush/utils/sizes.dart';
import '../../../utils/colors.dart';

class OfferCard extends ConsumerStatefulWidget {
  final dynamic data;
  const OfferCard({super.key, this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OfferCardState();
}

class _OfferCardState extends ConsumerState<OfferCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    log("====================>>>>>>>>>>${widget.data}");
    return Stack(
      children: [
        InkWell(
          onTap: () {
            navigationPush(context, OfferDetailScreen(id: widget.data['_id']));
          },
          child: Card(
            color: Colors.white,
            elevation: 1,
            child: Container(
              height: 120.h,
              width: 150.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heightSizedBox(30.0),
                  widget.data['image'] != null
                      ? Center(
                          child: Image.network(
                            widget.data['image'],
                            height: 50,
                            width: 120,
                          ),
                        )
                      : Center(
                          child: Image.asset(
                            "assets/images/amazon-logo-s3f.png",
                            height: 50,
                            width: 120,
                          ),
                        ),
                  heightSizedBox(10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Expires on',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            formatDate("${widget.data['expires_in']}"),
                            style: const TextStyle(
                                fontSize: 11,
                                color: Colors.red,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          return InkWell(
                            onTap: () async {
                              await ref
                                  .read(OffersRepoProvider)
                                  .grabDeal(widget.data['_id']);
                            },
                            child: Container(
                              height: 20,
                              width: 65,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                  child: Text(
                                'GRAB DEAL',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 20,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                _calculateDiscountText(widget.data),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Center(
              child: IconButton(
                  onPressed: () async {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                    if (isFavorite) {
                      var data = await ref
                          .read(OffersRepoProvider)
                          .saveOffer(widget.data['_id']);

                      ref
                          .read(secureStoargeProvider)
                          .writeData(key: "isFavorite", value: "True");
                      // setState(() {
                      //   isFavorite = data['data']['following'];
                      // });
                      log("data=$data");
                    } else {
                      ref
                          .read(OffersRepoProvider)
                          .removeOffer(widget.data['_id']);
                    }
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: isFavorite ? Colors.red : Colors.black,
                  ))),
        ),
      ],
    );
  }
}

String _calculateDiscountText(Map<String, dynamic> data) {
  // Convert amount and discount_value to double, defaulting to 0.0 if null or not parsable
  double amount = data['amount'] != null
      ? double.tryParse(data['amount'].toString()) ?? 0.0
      : 0.0;
  double discountValue = data['discount_value'] != null
      ? double.tryParse(data['discount_value'].toString()) ?? 0.0
      : 0.0;

  // Calculate the discount percentage
  double discountPercentage = amount != 0 ? (discountValue / amount) * 100 : 0;

  // Return only the percentage text
  return "${discountPercentage.toStringAsFixed(0)}% off";
}

// class OffersCard extends StatefulWidget {
//   final dynamic data;
//   const OffersCard({super.key, this.data});

//   @override
//   // ignore: library_private_types_in_public_api
//   _OffersCardState createState() => _OffersCardState();
// }

// class _OffersCardState extends State<OffersCard> {
//   bool isFavorite = false;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         InkWell(
//           onTap: () {
//             navigationPush(context, OfferDetailScreen(id: widget.data['_id']));
//           },
//           child: Card(
//             color: Colors.white,
//             elevation: 1,
//             child: Container(
//               height: 140,
//               width: 150,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Colors.white,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   heightSizedBox(30.0),
//                   widget.data['image'] != null
//                       ? Center(
//                           child: Image.network(
//                             widget.data['image'],
//                             height: 50,
//                             width: 120,
//                           ),
//                         )
//                       : Center(
//                           child: Image.asset(
//                             "assets/images/amazon-logo-s3f.png",
//                             height: 50,
//                             width: 120,
//                           ),
//                         ),
//                   heightSizedBox(10.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Column(
//                         children: [
//                           const Text(
//                             'Expires in',
//                             style: TextStyle(
//                                 fontSize: 12, fontWeight: FontWeight.w600),
//                           ),
//                           Text(
//                             formatDate("${widget.data['expires_in']}"),
//                             style: const TextStyle(
//                                 fontSize: 11,
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ],
//                       ),
//                       Consumer(
//                         builder: (context, ref, child) {
//                           return InkWell(
//                             onTap: () async {
//                               await ref
//                                   .read(OffersRepoProvider)
//                                   .grabDeal(widget.data['_id']);
//                             },
//                             child: Container(
//                               height: 20,
//                               width: 65,
//                               decoration: BoxDecoration(
//                                 color: Colors.orange,
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: const Center(
//                                   child: Text(
//                                 'GRAB DEAL',
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 10),
//                               )),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           top: 0,
//           right: 0,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             height: 20,
//             // width: 60,
//             decoration: BoxDecoration(
//               color: Colors.red,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Center(
//                 child: Text(
//               "${widget.data['discount_value']}₹ off",
//               style: const TextStyle(color: Colors.white, fontSize: 12),
//             )),
//           ),
//         ),
//         Consumer(
//           builder: (context, ref, child) {
//             return Positioned(
//               top: 0,
//               left: 0,
//               child: Center(
//                   child: IconButton(
//                       onPressed: () {
//                         log("${widget.data['_id']}");
//                         setState(() {
//                           isFavorite = !isFavorite;
//                         });
//                         if (isFavorite) {
//                           ref.read(OffersRepoProvider).saveOffer(widget.data['_id']);
//                         } else {
//                           ref.read(OffersRepoProvider).removeOffer(widget.data['_id']);
//                         }
//                       },
//                       icon: Icon(
//                         isFavorite ? Icons.favorite : Icons.favorite_outline,
//                         color: isFavorite ? Colors.red : Colors.black,
//                       ))),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

class OffersCardBrandScr extends StatelessWidget {
  const OffersCardBrandScr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: Colors.white,
          elevation: 1,
          child: Container(
            height: 140,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                heightSizedBox(30.0),
                Center(
                  child: Image.asset(
                    "assets/images/amazon-logo-s3f.png",
                    height: 50,
                    width: 120,
                  ),
                ),
                heightSizedBox(10.0),
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
                      width: 65,
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
        const Positioned(
          top: 15,
          left: 10,
          child: Center(child: Icon(Icons.favorite_outline)),
        ),
      ],
    );
  }
}
