import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/offer/repo/offers_repo.dart';
import 'package:rush/utils/bottom_bar.dart';
import 'package:rush/utils/navigation.dart';
import 'package:rush/utils/sizes.dart';
import '../../../common/image_slider.dart';
import '../../../utils/colors.dart';
import '../components/offer_screen_comp.dart';

final getOffersProvider = FutureProvider.autoDispose((ref) async {
  final getOffers = await ref.watch(OffersRepoProvider).getOffers();

  return getOffers;
});

final getMensOfferProvider =
    FutureProvider.autoDispose.family((ref, String id) async {
  final getOffers =
      await ref.watch(OffersRepoProvider).getCategoriOffers(id: id);

  return getOffers;
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
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getOfferData = ref.watch(getOffersProvider);

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
            icon: const Icon(Icons.arrow_back)),
      ),
      body: getOfferData.when(
        data: (data) {
          return Column(
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
              heightSizedBox(10.0),
          
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final getMensData = ref.watch(
                            getMensOfferProvider('66332c9a65beb9b60342c7de'));

                        return getMensData.when(
                          data: (data) {
                            if (data.isEmpty) {
                              return const Center(child: Text("No Data"));
                            }

                            return GridView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                ),
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      OfferCard(
                                        data: data[index],
                                      ),
                                    ],
                                  );
                                });
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
                        final getMensData = ref.watch(
                            getMensOfferProvider('66332d6765beb9b60342c7e4'));

                        return getMensData.when(
                          data: (data) {
                            if (data.isEmpty) {
                              return const Center(child: Text("No Data"));
                            }

                            return GridView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                ),
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      OfferCard(
                                        data: data[index],
                                      ),
                                    ],
                                  );
                                });
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
                        final getMensData = ref.watch(
                            getMensOfferProvider('66332e22933f45c89ec839ce'));

                        return getMensData.when(
                          data: (data) {
                            if (data.isEmpty) {
                              return const Center(child: Text("No Data"));
                            }
                            return GridView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                ),
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      OfferCard(
                                        data: data[index],
                                      ),
                                    ],
                                  );
                                });
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
                        final getMensData = ref.watch(
                            getMensOfferProvider('66332de865beb9b60342c7e7'));

                        return getMensData.when(
                          data: (data) {
                            if (data.isEmpty) {
                              return const Center(child: Text("No Data"));
                            }
                            return GridView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                ),
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      OfferCard(
                                        data: data[index],
                                      ),
                                    ],
                                  );
                                });
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
          );
        },
        error: (error, stackTrace) => const Center(
          child: Text("Something Went Wrong"),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
