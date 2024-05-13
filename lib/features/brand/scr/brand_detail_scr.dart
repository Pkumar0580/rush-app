import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import '../../../utils/navigation.dart';
import '../../../utils/sizes.dart';

class Stores extends StatelessWidget {
  final List stores;

  const Stores({super.key, required this.stores});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Stores",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var i = 0; i < stores.length; i++)
                    SizedBox(
                      height: null,
                      width: 140,
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/Store.png"),
                              heightSizedBox(5.0),

                              RatingBarIndicator(
                                rating: (stores[i]['rating'] ?? 0).toDouble(),
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 20,
                                itemPadding: EdgeInsets.zero,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     for (int i = 0; i < 5; i++)
                              //       const Icon(
                              //         Icons.star,
                              //         size: 10,
                              //       )
                              //   ],
                              // ),
                              heightSizedBox(5.0),
                              Center(
                                  child: Text(
                                stores[i]['name'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              )),
                              heightSizedBox(2.0),
                              Text(
                                stores[i]['location'],
                                style: const TextStyle(
                                    color: Color(0xffFF6B00), fontSize: 13),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TopBanner extends StatelessWidget {
  final String logo, title;
  const TopBanner({super.key, required this.logo, required this.title});

  @override
  Widget build(BuildContext context) {
    // log(logo);
    return Container(
      width: width(context),
      height: null,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/banner.png"))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    navigationPop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ))
            ],
          ),
          SizedBox(
            height: 140,
            width: 150,
            child: Card(
                color: Colors.white,
                child: Container(
                  height: 127,
                  width: 148,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(
                      logo,
                    ),
                  ),
                )

                //  Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: Image.network(
                //     // "assets/images/amazon-logo-s3f.png",
                //     logo,
                //     fit: BoxFit.contain,
                //   ),
                // ),
                ),
          ),
          heightSizedBox(5.0),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
          ),
          heightSizedBox(10.0),
        ],
      ),
    );
  }
}
