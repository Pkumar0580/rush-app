import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/offer/repo/offers_repo.dart';
import '../../../utils/colors.dart';

final getOfferProvider = FutureProvider((ref) async {
  
  final getOffer = ref.watch(OffersRepoProvider);
  log("getOffer=>$getOffer");
  return getOffer;
});

// final getProfileProvider = FutureProvider((ref) async {
//   final getdata = await ref.watch(profileRepoProvider).getProfile();
//   return getdata;
// });




class OffersScreen extends ConsumerStatefulWidget {
  const OffersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OffersScreenState();
}

class _OffersScreenState extends ConsumerState<OffersScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);

    final getProfileData = ref.watch(getOfferProvider);
    log("getProfileData=> $getProfileData");
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
        body: getProfileData.when(
          data: (data) {
            log("data1 $data");
            return Column(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xff204571)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 30.0, left: 10.0, right: 10.0),
                    child: SizedBox(
                      height: 40,
                      child: CupertinoSearchTextField(
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                    Tab(text: 'Latest'),
                    Tab(text: 'Expiring Soon'),
                    Tab(text: 'Discount'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: 5,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) {
                            return const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OffersCard(),
                                // BrendsLogoCard(
                                //   src: "assets/images/FliOffersScreenart-Logo.png",
                                // )
                              ],
                            );
                          }),
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: 5,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) {
                            return const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OffersCard(),
                                // BrendsLogoCard(
                                //   src: "assets/images/FliOffersScreenart-Logo.png",
                                // )
                              ],
                            );
                          }),
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: 5,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) {
                            return const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OffersCard(),
                                // BrendsLogoCard(
                                //   src: "assets/images/FliOffersScreenart-Logo.png",
                                // )
                              ],
                            );
                          }),
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: 5,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) {
                            return const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OffersCard(),
                                // BrendsLogoCard(
                                //   src: "assets/images/FliOffersScreenart-Logo.png",
                                // )
                              ],
                            );
                          })
                    ],
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) => const Center(
            child: Text("Something Went Wrong"),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

// class OfferScreen extends StatefulWidget {
//   const OfferScreen({super.key});

//   @override
//   State<OfferScreen> createState() => _MyOfferScreenState();
// }

// class _MyOfferScreenState extends State<OfferScreen>
//     with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     TabController tabController = TabController(length: 4, vsync: this);
//     statusBarColorChange(AppColor.statusBarColor);
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColor.backgroundColor,
//         appBar: AppBar(
//           backgroundColor: AppColor.appbarColor,
//           title: const Text(
//             "Offers",
//             style: TextStyle(color: Colors.white),
//           ),
//           automaticallyImplyLeading: true,
//         ),
//         body: Column(
//           children: [
//             Container(
//               height: 100,
//               width: double.infinity,
//               decoration: const BoxDecoration(color: Color(0xff204571)),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     top: 30, bottom: 30.0, left: 10.0, right: 10.0),
//                 child: SizedBox(
//                   height: 40,
//                   child: CupertinoSearchTextField(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(21)),
//                   ),
//                 ),
//               ),
//             ),
//             TabBar(
//               indicatorColor: const Color(0xff1F4570),
//               indicatorSize: TabBarIndicatorSize.tab,
//               labelStyle: const TextStyle(
//                 color: Color(0xff000000),
//                 fontWeight: FontWeight.w500,
//               ),
//               controller: tabController,
//               tabs: const [
//                 Tab(text: 'Popular'),
//                 Tab(text: 'Latest'),
//                 Tab(text: 'Expiring Soon'),
//                 Tab(text: 'Discount'),
//               ],
//             ),
//             Expanded(
//               child: TabBarView(
//                 controller: tabController,
//                 children: [
//                   GridView.builder(
//                       shrinkWrap: true,
//                       itemCount: 5,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10.0,
//                         mainAxisSpacing: 10.0,
//                       ),
//                       itemBuilder: (context, index) {
//                         return const Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             OffersCard(),
//                             // BrendsLogoCard(
//                             //   src: "assets/images/FliOffersScreenart-Logo.png",
//                             // )
//                           ],
//                         );
//                       }),
//                   GridView.builder(
//                       shrinkWrap: true,
//                       itemCount: 5,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10.0,
//                         mainAxisSpacing: 10.0,
//                       ),
//                       itemBuilder: (context, index) {
//                         return const Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             OffersCard(),
//                             // BrendsLogoCard(
//                             //   src: "assets/images/FliOffersScreenart-Logo.png",
//                             // )
//                           ],
//                         );
//                       }),
//                   GridView.builder(
//                       shrinkWrap: true,
//                       itemCount: 5,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10.0,
//                         mainAxisSpacing: 10.0,
//                       ),
//                       itemBuilder: (context, index) {
//                         return const Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             OffersCard(),
//                             // BrendsLogoCard(
//                             //   src: "assets/images/FliOffersScreenart-Logo.png",
//                             // )
//                           ],
//                         );
//                       }),
//                   GridView.builder(
//                       shrinkWrap: true,
//                       itemCount: 5,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10.0,
//                         mainAxisSpacing: 10.0,
//                       ),
//                       itemBuilder: (context, index) {
//                         return const Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             OffersCard(),
//                             // BrendsLogoCard(
//                             //   src: "assets/images/FliOffersScreenart-Logo.png",
//                             // )
//                           ],
//                         );
//                       })
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class OffersCard extends StatelessWidget {
  const OffersCard({
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
        const Positioned(
          top: 15,
          left: 10,
          child: Center(child: Icon(Icons.favorite_outline)),
        ),
      ],
    );
  }
}

class BrendsLogoCard extends StatelessWidget {
  final Function()? onTap;
  final String src;
  const BrendsLogoCard({super.key, required this.src, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 1,
        child: Container(
          height: 127,
          width: 148,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Image.network(
            src,
          ),
        ),
      ),
    );
  }
}
