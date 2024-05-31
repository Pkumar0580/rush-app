import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/offer/repo/offers_repo.dart';
import 'package:rush/utils/bottom_bar.dart';
import 'package:rush/utils/navigation.dart';
import '../../../utils/colors.dart';
import '../scr/offer_screen_scr.dart';

final getOfferProvider = FutureProvider.autoDispose((ref) async {
  final getOffer = await ref.watch(OffersRepoProvider).getOffers();

  return getOffer;
});

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

    final getOfferData = ref.watch(getOfferProvider);

    return SafeArea(
      child: Scaffold(
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
          // automaticallyImplyLeading: true,
        ),
        body: getOfferData.when(
          data: (data) {
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
                          borderRadius: BorderRadius.circular(21),
                        ),
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
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OffersCard(
                                  data: data[index],
                                ),
                              ],
                            );
                          }),
                      GridView.builder(
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OffersCard(
                                    data: data[index],
                                    ),
                              ],
                            );
                          }),
                      GridView.builder(
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OffersCard(
                                    data: data[index],
                                    ),
                              ],
                            );
                          }),
                      GridView.builder(
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OffersCard(
                                    data: data[index],
                                    ),
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
