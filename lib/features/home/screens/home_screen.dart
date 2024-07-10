import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rush/common/image_slider.dart';
import 'package:rush/features/offer/components/offer_screen_comp.dart';
import 'package:rush/features/offer/repo/offers_repo.dart';
import 'package:rush/utils/colors.dart';
import 'package:rush/utils/sizes.dart';
import '../scr/drawer.dart';
import '../scr/home_screen_scr.dart';

final getHomeOffersProvider = FutureProvider.autoDispose((ref) async {
  final getOffers = await ref.watch(OffersRepoProvider).getHomeOffers();

  return getOffers;
});

class HomeScreen extends ConsumerWidget {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        key: drawerKey,
        drawer: const Drawer(
          child: CusDrawer(),
        ),
        appBar: AppBar(
          backgroundColor: AppColor.appbarColor,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: InkWell(
              onTap: () {
                drawerKey.currentState?.openDrawer();
              },
              child: SvgPicture.asset(
                'assets/images/Vector.svg',
              ),
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
              Consumer(
                builder: (context, ref, child) {
                  final getOffer = ref.watch(getHomeOffersProvider);
                  return getOffer.when(
                    data: (data) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              for (int i = 0; i < data.length; i++)
                                OfferCard(
                                  data: data[i],
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                    error: (error, stackTrace) =>
                        const Text("Something Went Wrong"),
                    loading: () => const Center(
                      child: Text("Loading........"),
                    ),
                  );
                },
              ),
              const BannerSlide()
            ],
          ),
        ));
  }
}
