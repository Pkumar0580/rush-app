import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rush/features/offer/screens/offer_detail_screen.dart';
import 'package:rush/utils/navigation.dart';
import 'package:rush/utils/sizes.dart';

class OffersCard extends StatelessWidget {
  final dynamic data;
  const OffersCard({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    // log("Data=========> $data");
    return Stack(
      children: [
        InkWell(
          onTap: () {
            navigationPush(context, OfferDetailScreen(id: data['_id']));
          },
          child: Card(
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
                  data['brand']['logo'] != null
                      ? Center(
                          child: Image.network(
                            data['brand']['logo'],
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
