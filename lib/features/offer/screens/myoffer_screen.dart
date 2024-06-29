import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/utils/colors.dart';
import '../components/offer_screen_comp.dart';
import '../repo/offers_repo.dart';

final getSavedOffersProvider = FutureProvider.autoDispose((ref) async {
  final getSavedOffers = await ref.watch(OffersRepoProvider).getSavedOffers();
  return getSavedOffers;
});

class MyOffers extends ConsumerWidget {
  const MyOffers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedOfferData = ref.watch(getSavedOffersProvider);
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.appbarColor,
          foregroundColor: Colors.white,
          title: const Text("My Offers"),
        ),
        body: savedOfferData.when(
          data: (data) {
            if (data.isEmpty) {
              return const Center(
                child: Text("No data available"),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 0.0,
                  ),
                  itemBuilder: (context, index) {
                    return OfferCard(
                      data: data[index],
                    );
                  }),
            );
          },
          error: (error, stackTrace) => const Text("Something went wrong"),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
