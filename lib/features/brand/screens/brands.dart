import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rush/features/brand/repo/brands_repo.dart';
import '../../../utils/api_method.dart';
import '../../../utils/bottom_bar.dart';
import '../../../utils/colors.dart';
import '../../../utils/navigation.dart';
import 'brand_details.dart';

final getBrandsCategoryProvider = FutureProvider.autoDispose
    .family<List<dynamic>, String>((ref, categoryWithSubcategory) async {
  final splitCategory = categoryWithSubcategory.split(':');
  final category = splitCategory[0];
  final subcategory = splitCategory.length > 1 ? splitCategory[1] : null;

  final getBrands = await ref.watch(brandRepoProvider).getBrandsCategory(
        category: category,
        subCategory: subcategory,
      );

  return getBrands;
});

class BrandScreen extends StatefulWidget {
  final int initialTabIndex;
  const BrandScreen({super.key, this.initialTabIndex = 0});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  List<dynamic> data = [];
  List<dynamic> filteredData = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  String selectedSubcategory = "";
  int currentTabIndex = 0; // Track the current tab index

  final Map<int, List<String>> buttonLabelsMap = {
    0: ["Formals", "Casuals", "Ethnic", "Sports", "Lounge"], // Men's fashion
    1: ["Formals", "Casuals", "Ethnic", "Sports", "Lounge"], // Women's fashion
    2: ["Kids' Dresses", "Kids' Tops", "Kids' Bottoms", "Kids' Outerwear"],
    3: ["Shoes", "Watches", "Leather", "Sunglasses"], // Accessories
  };

  final Map<int, List<bool>> isSelectedListMap = {
    0: [false, false, false, false, false], // Men's fashion
    1: [false, false, false, false, false], // Women's fashion
    2: [false, false, false, false], // Kids Wear
    3: [false, false, false, false], // Accessories
  };

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    fetchData((responseData) {
      setState(() {
        data = responseData;
        filteredData = responseData;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    )..addListener(() {
        setState(() {
          currentTabIndex = tabController.index;
        });
      });
  }

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
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColor.appbarColor,
        title: const Text("Brands"),
        leading: IconButton(
          onPressed: () {
            navigateTo(const BottomBar());
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Column(
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
                    controller: searchController,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                color:
                                    isSelectedListMap[currentTabIndex]![index]
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
                  Consumer(
                    builder: (context, ref, child) {
                      final getMensData = ref.watch(getBrandsCategoryProvider(
                          "Men's fashion:${selectedSubcategory}"));

                      return getMensData.when(
                        data: (data) {
                          if (data.isEmpty) {
                            return const Center(child: Text("No Data"));
                          }
                          return MyBrandTabScreen(data: data);
                        },
                        error: (error, stackTrace) => const Text("Error"),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final getWomensData = ref.watch(getBrandsCategoryProvider(
                          "Ladies fashion:${selectedSubcategory}"));

                      return getWomensData.when(
                        data: (data) {
                          if (data.isEmpty) {
                            return const Center(child: Text("No Data"));
                          }
                          return MyBrandTabScreen(data: data);
                        },
                        error: (error, stackTrace) => const Text("Error"),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final getKidsData = ref.watch(getBrandsCategoryProvider(
                          "Kids Wear:${selectedSubcategory}"));

                      return getKidsData.when(
                        data: (data) {
                          if (data.isEmpty) {
                            return const Center(child: Text("No Data"));
                          }
                          return MyBrandTabScreen(data: data);
                        },
                        error: (error, stackTrace) => const Text("Error"),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final getAccessoriesData = ref.watch(
                          getBrandsCategoryProvider(
                              "Accessories:${selectedSubcategory}"));

                      return getAccessoriesData.when(
                        data: (data) {
                          if (data.isEmpty) {
                            return const Center(child: Text("No Data"));
                          }
                          return MyBrandTabScreen(data: data);
                        },
                        error: (error, stackTrace) => const Text("Error"),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
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
  final data;
  const MyBrandTabScreen({
    super.key,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return BrendsLogoCard(
            src: data[index]['logo'],
            onTap: () {
              navigationPush(
                context,
                BrandsDetails(
                  id: data[index]["_id"],
                ),
              );
            },
          );
        },
      ),
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
          height: 127.h,
          width: 148.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.network(
              src,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
