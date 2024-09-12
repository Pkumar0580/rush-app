import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/offer/repo/offers_repo.dart';
import 'package:rush/utils/bottom_bar.dart';
import 'package:rush/utils/navigation.dart';
import '../../../common/image_slider.dart';
import '../../../utils/colors.dart';
import '../components/offer_screen_comp.dart';

final getMensOfferProvider = FutureProvider.autoDispose
    .family<List<dynamic>, String>((ref, idWithSubcategory) async {
  final splitData = idWithSubcategory.split(':');
  final id = splitData[0];
  final subcategory = splitData.length > 1 ? splitData[1] : null;

  final getOffers = await ref
      .watch(OffersRepoProvider)
      .getCategoriOffers(id: id, subCategory: subcategory);
  return getOffers ?? [];
});

class OffersScreen extends ConsumerStatefulWidget {
  final int initialTabIndex;
  const OffersScreen({super.key, this.initialTabIndex = 0});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OffersScreenState();
}

class _OffersScreenState extends ConsumerState<OffersScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.initialTabIndex);
    // Listen to tab changes and reset subcategory when the tab changes
    tabController.addListener(() {
      setState(() {
        currentTabIndex = tabController.index;
        selectedSubcategory = ""; // Reset subcategory on tab change
        isSelectedListMap[currentTabIndex] = List.generate(
            buttonLabelsMap[currentTabIndex]!.length, (index) => false);
      });
    });
  }

  String selectedSubcategory = "";
  int currentTabIndex = 0;

  final Map<int, List<String>> buttonLabelsMap = {
    0: ["Formals", "Casuals", "Ethnic", "Sports", "Lounge"], // Men's fashion
    1: ["Formals", "Casuals", "Ethnic", "Sports", "Lounge"], // Women's fashion
    2: [], // Kids Wear
    3: ["Shoes", "Watches", "Leather", "Sunglasses"], // Accessories
  };

  final Map<int, List<bool>> isSelectedListMap = {
    0: [false, false, false, false, false], // Men's fashion
    1: [false, false, false, false, false], // Women's fashion
    2: [], // Kids Wear
    3: [false, false, false, false], // Accessories
  };

  void _onButtonClick(int index) {
    setState(() {
      isSelectedListMap[currentTabIndex] = List.generate(
        isSelectedListMap[currentTabIndex]!.length,
        (i) => i == index,
      );
      selectedSubcategory = buttonLabelsMap[currentTabIndex]![index];
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.appbarColor,
        foregroundColor: Colors.white,
        title: const Text(
          "Offers",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            navigateTo(const BottomBar());
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          const ImageSlide(),
          TabBar(
            indicatorColor: const Color(0xff1F4570),
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.w500,
            ),
            controller: tabController,
            tabs: const [
              Tab(text: "Men's"),
              Tab(text: "Women's"),
              Tab(text: 'Kids'),
              Tab(text: 'Accessories'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  buttonLabelsMap[currentTabIndex]!.length,
                  (index) {
                    return GestureDetector(
                      onTap: () => _onButtonClick(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 22,
                        width: 80,
                        decoration: BoxDecoration(
                          color: isSelectedListMap[currentTabIndex]![index]
                              ? AppColor.appbarColor
                              : Colors.transparent,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Center(
                          child: Text(
                            buttonLabelsMap[currentTabIndex]![index],
                            style: TextStyle(
                              color: isSelectedListMap[currentTabIndex]![index]
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                _buildOfferTab(context, ref, '66332c9a65beb9b60342c7de'),
                _buildOfferTab(context, ref, '66332d6765beb9b60342c7e4'),
                _buildOfferTab(context, ref, '66332e22933f45c89ec839ce'),
                _buildOfferTab(context, ref, '66332de865beb9b60342c7e7'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferTab(BuildContext context, WidgetRef ref, String id) {
    final getOffersData =
        ref.watch(getMensOfferProvider('$id:$selectedSubcategory'));

    return getOffersData.when(
      data: (data) {
        if (data.isEmpty) {
          return const Center(child: Text("No Data"));
        }
        return GridView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OfferCard(
                  data: data[index],
                ),
              ],
            );
          },
        );
      },
      error: (error, stackTrace) => const Text("Error"),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// class OffersScreen extends ConsumerStatefulWidget {
//   final int initialTabIndex;
//   const OffersScreen({super.key, this.initialTabIndex = 0});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _OffersScreenState();
// }

// class _OffersScreenState extends ConsumerState<OffersScreen>
//     with TickerProviderStateMixin {
//   late TabController tabController;

//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(
//         length: 4, vsync: this, initialIndex: widget.initialTabIndex);
//   }

//   String selectedSubcategory = "";
//   int currentTabIndex = 0;

//   final Map<int, List<String>> buttonLabelsMap = {
//     0: ["Formals", "Casuals", "Ethnic", "Sports", "Lounge"], // Men's fashion
//     1: ["Formals", "Casuals", "Ethnic", "Sports", "Lounge"], // Women's fashion
//     2: [],
//     3: ["Shoes", "Watches", "Leather", "Sunglasses"], // Accessories
//   };

//   final Map<int, List<bool>> isSelectedListMap = {
//     0: [false, false, false, false, false], // Men's fashion
//     1: [false, false, false, false, false], // Women's fashion
//     2: [false, false, false, false], // Kids Wear
//     3: [false, false, false, false], // Accessories
//   };

//   void _onButtonClick(int index) {
//     setState(() {
//       isSelectedListMap[currentTabIndex] = List.generate(
//         isSelectedListMap[currentTabIndex]!.length,
//         (i) => i == index,
//       );
//       selectedSubcategory = buttonLabelsMap[currentTabIndex]![index];
//     });
//   }

//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final getOfferData = ref.watch(getOffersProvider);

//     return Scaffold(
//         backgroundColor: AppColor.backgroundColor,
//         appBar: AppBar(
//           backgroundColor: AppColor.appbarColor,
//           foregroundColor: Colors.white,
//           title: const Text(
//             "Offers",
//             style: TextStyle(color: Colors.white),
//           ),
//           leading: IconButton(
//               onPressed: () {
//                 navigateTo(const BottomBar());
//               },
//               icon: const Icon(Icons.arrow_back)),
//         ),
//         body: Column(
//           children: [
//             const ImageSlide(),
//             TabBar(
//               indicatorColor: const Color(0xff1F4570),
//               indicatorSize: TabBarIndicatorSize.tab,
//               labelStyle: const TextStyle(
//                 color: Color(0xff000000),
//                 fontWeight: FontWeight.w500,
//               ),
//               controller: tabController,
//               tabs: const [
//                 Tab(text: "Men's"),
//                 Tab(text: "Women's"),
//                 Tab(text: 'Kids'),
//                 Tab(text: 'Accessories'),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: List.generate(
//                     buttonLabelsMap[currentTabIndex]!.length,
//                     (index) {
//                       return GestureDetector(
//                         onTap: () => _onButtonClick(index),
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 5),
//                           height: 22,
//                           width: 80,
//                           decoration: BoxDecoration(
//                             color: isSelectedListMap[currentTabIndex]![index]
//                                 ? AppColor.appbarColor
//                                 : Colors.transparent,
//                             border: Border.all(color: Colors.black),
//                             borderRadius: BorderRadius.circular(11),
//                           ),
//                           child: Center(
//                             child: Text(
//                               buttonLabelsMap[currentTabIndex]![index],
//                               style: TextStyle(
//                                 color:
//                                     isSelectedListMap[currentTabIndex]![index]
//                                         ? Colors.white
//                                         : Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: TabBarView(
//                 controller: tabController,
//                 children: [
//                   Consumer(
//                     builder: (context, ref, child) {
//                       final getMensData = ref.watch(
//                           getMensOfferProvider('66332c9a65beb9b60342c7de'));

//                       return getMensData.when(
//                         data: (data) {
//                           if (data.isEmpty) {
//                             return const Center(child: Text("No Data"));
//                           }

//                           return GridView.builder(
//                               shrinkWrap: true,
//                               itemCount: data.length,
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 10.0,
//                                 mainAxisSpacing: 10.0,
//                               ),
//                               itemBuilder: (context, index) {
//                                 return Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     OfferCard(
//                                       data: data[index],
//                                     ),
//                                   ],
//                                 );
//                               });
//                         },
//                         error: (error, stackTrace) => const Text("Error"),
//                         loading: () => const Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                       );
//                     },
//                   ),
//                   Consumer(
//                     builder: (context, ref, child) {
//                       final getMensData = ref.watch(
//                           getMensOfferProvider('66332d6765beb9b60342c7e4'));

//                       return getMensData.when(
//                         data: (data) {
//                           if (data.isEmpty) {
//                             return const Center(child: Text("No Data"));
//                           }

//                           return GridView.builder(
//                               shrinkWrap: true,
//                               itemCount: data.length,
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 10.0,
//                                 mainAxisSpacing: 10.0,
//                               ),
//                               itemBuilder: (context, index) {
//                                 return Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     OfferCard(
//                                       data: data[index],
//                                     ),
//                                   ],
//                                 );
//                               });
//                         },
//                         error: (error, stackTrace) => const Text("Error"),
//                         loading: () => const Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                       );
//                     },
//                   ),
//                   Consumer(
//                     builder: (context, ref, child) {
//                       final getMensData = ref.watch(
//                           getMensOfferProvider('66332e22933f45c89ec839ce'));

//                       return getMensData.when(
//                         data: (data) {
//                           if (data.isEmpty) {
//                             return const Center(child: Text("No Data"));
//                           }
//                           return GridView.builder(
//                               shrinkWrap: true,
//                               itemCount: data.length,
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 10.0,
//                                 mainAxisSpacing: 10.0,
//                               ),
//                               itemBuilder: (context, index) {
//                                 return Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     OfferCard(
//                                       data: data[index],
//                                     ),
//                                   ],
//                                 );
//                               });
//                         },
//                         error: (error, stackTrace) => const Text("Error"),
//                         loading: () => const Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                       );
//                     },
//                   ),
//                   Consumer(
//                     builder: (context, ref, child) {
//                       final getMensData = ref.watch(
//                           getMensOfferProvider('66332de865beb9b60342c7e7'));

//                       return getMensData.when(
//                         data: (data) {
//                           if (data.isEmpty) {
//                             return const Center(child: Text("No Data"));
//                           }
//                           return GridView.builder(
//                               shrinkWrap: true,
//                               itemCount: data.length,
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 10.0,
//                                 mainAxisSpacing: 10.0,
//                               ),
//                               itemBuilder: (context, index) {
//                                 return Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     OfferCard(
//                                       data: data[index],
//                                     ),
//                                   ],
//                                 );
//                               });
//                         },
//                         error: (error, stackTrace) => const Text("Error"),
//                         loading: () => const Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
// }
