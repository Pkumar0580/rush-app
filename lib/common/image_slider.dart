import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class ImageSlide extends StatefulWidget {
  const ImageSlide({super.key});

  @override
  State<ImageSlide> createState() => _ImageSlideState();
}

class _ImageSlideState extends State<ImageSlide> {
  List itemList = [
    {"id": 1, "image": "assets/images/Rectangle14.png"},
    {"id": 2, "image": "assets/images/womensfashion.jpg"},
    {"id": 3, "image": "assets/images/kidsfashion.jpg"},
    {"id": 3, "image": "assets/images/Accssories.jpg"},
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () {},
              child: CarouselSlider(
                  carouselController: carouselController,
                  items: itemList
                      .map((e) => Image.asset(
                            e['image'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ))
                      .toList(),
                  options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      autoPlay: true,
                      aspectRatio: 2,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      })),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (int i = 0; i < itemList.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 8,
                        width: 8,
                        // width: currentIndex == i ? 25 : 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: currentIndex == i
                              ? AppColor.btnColor
                              : Colors.white,
                        ),
                      ),
                    )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

class BannerSlide extends StatefulWidget {
  const BannerSlide({super.key});

  @override
  State<BannerSlide> createState() => _BannerSlideState();
}

class _BannerSlideState extends State<BannerSlide> {
  List itemList = [
    {"id": 1, "image": "assets/images/banner1.jpg"},
    {"id": 2, "image": "assets/images/banner2.jpg"},
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () {},
              child: CarouselSlider(
                carouselController: carouselController,
                items: itemList
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(21),
                            child: SizedBox(
                              height: 50,
                              child: Image.asset(
                                e['image'],
                                fit: BoxFit.cover,
                                // width: double.infinity,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: true,
                    aspectRatio: 2,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    }),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (int i = 0; i < itemList.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: currentIndex == i
                              ? AppColor.btnColor
                              : Colors.white,
                        ),
                      ),
                    )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
