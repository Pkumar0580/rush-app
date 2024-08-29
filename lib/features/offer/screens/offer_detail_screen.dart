import 'package:flutter/material.dart';
import 'package:rush/utils/button.dart';
import 'package:rush/utils/colors.dart';
import '../../home/scr/home_screen_scr.dart';
import '../components/offer_detail_comp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/offer/repo/offers_repo.dart';

final getOfferProvoder = FutureProvider.autoDispose.family((ref, String id) {
  final getOffer = ref.watch(OffersRepoProvider).getOffersById(id: id);

  return getOffer;
});

class OfferDetailScreen extends ConsumerWidget {
  final String id;
  const OfferDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getOffer = ref.watch(getOfferProvoder(id));

    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.appbarColor,
          foregroundColor: Colors.white,
          title: const Text("Offer Details"),
        ),
        body: getOffer.when(
          data: (data) {
            return SingleChildScrollView(
              child: Column(children: [
                TopContainer(data: data),
                AddressContainer(data: data),
                BrandComp(data: data),
                CategorieComp(data: data),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Btn(
                      text: "Grab Deal",
                      onPressed: () async {
                        await ref
                            .read(OffersRepoProvider)
                            .grabDeal(data['offer']['_id']);
                      }),
                )
              ]),
            );
          },
          error: (error, stackTrace) =>
              const Center(child: Text("Something went wrong")),
          loading: () => const Center(child: CircularProgressIndicator()),
        ));
  }
}

class CategorieComp extends StatelessWidget {
  final dynamic data;
  const CategorieComp({
    super.key,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return data["offer"]['brand']['categories'][0] != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Categories/Sub Categories",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProdItem(
                      text: "Men'S Fashion",
                      src: 'assets/images/mensFashion.png',
                      onTap: () {},
                    ),
                    Expanded(
                        child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 8.0,
                      runSpacing: 10.0,
                      children: [
                        for (var i = 0;
                            i <
                                data["offer"]['brand']['categories'][0]
                                        ['sub_categories']
                                    .length;
                            i++)
                          if (data["offer"]['brand']['categories'][0]
                                  ['sub_categories'][i] !=
                              null)
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(21),
                                color: const Color(0xffD9D9D9),
                                border: Border.all(
                                  color: const Color(0xff767676),
                                  width: 0.3,
                                ),
                              ),
                              child: Text(
                                "${data["offer"]['brand']['categories'][0]['sub_categories'][i]}",
                                style:
                                    const TextStyle(color: Color(0xff5F5F5F)),
                              ),
                            ),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
