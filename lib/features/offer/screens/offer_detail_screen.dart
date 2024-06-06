import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rush/features/offer/repo/offers_repo.dart';
import 'package:intl/intl.dart';
import 'package:rush/utils/colors.dart';
import 'package:rush/utils/sizes.dart';

import '../../brand/screens/brands.dart';
import '../components/offer_detail_comp.dart';

final getOfferProvoder = FutureProvider.family((ref, String id) {
  final getOffer = ref.watch(OffersRepoProvider).getOffersById(id: id);

  return getOffer;
});

class OfferDetailScreen extends ConsumerWidget {
  final String id;
  const OfferDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getOffer = ref.watch(getOfferProvoder(id));
    log("id=$id");
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          title: const Text("Offer Details"),
        ),
        body: getOffer.when(
          data: (data) {
            log("Offer by id $data");
            return SingleChildScrollView(
              child: Column(
                children: [
                  TopContainer(data: data),
                  AddressContainer(data: data),
                  BrandComp(data:data),
                ],
              ),
            );
          },
          error: (error, stackTrace) =>
              const Center(child: Text("Something went wrong")),
          loading: () => const Center(child: CircularProgressIndicator()),
        ));
  }
}
