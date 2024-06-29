import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/brand/repo/brands_repo.dart';
import '../../../utils/api_method.dart';
import '../../../utils/colors.dart';
import '../../../utils/navigation.dart';
import '../../../utils/sizes.dart';
import '../../offer/components/offer_screen_comp.dart';
import '../../offer/screens/offers_screen.dart';
import '../scr/brand_detail_scr.dart';

class BrandsDetails extends StatefulWidget {
  final String id;

  const BrandsDetails({super.key, required this.id});

  @override
  State<BrandsDetails> createState() => _BrandsDetailsState();
}

class _BrandsDetailsState extends State<BrandsDetails> {
  BrandDetail data = BrandDetail(
      id: "",
      title: "",
      description: "",
      logo: "",
      redirectLink: "",
      stores: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      v: 0);

  @override
  void initState() {
    fetchBrandDetailWithID((responseData) {
      setState(() {
        data = responseData;
      });
    }, id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: data.id.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBanner(
                      logo: data.logo,
                      title: data.title,
                      url: data.redirectLink,
                    ),
                    Stores(stores: data.stores),
                    // const Categories(),
                    TopOffers(
                      id: widget.id,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

final getBrandOffer = FutureProvider.family((ref, String id) async {
  final getdata = await ref.watch(brandRepoProvider).getBrandsOffers(id);
  return getdata;
});

class TopOffers extends ConsumerWidget {
  final String id;
  const TopOffers({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandOffers = ref.watch(getBrandOffer(id));
    return brandOffers.when(
      data: (data) {
        log("OffersBrand$data");
        return Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Top Offers",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      navigationPush(context, const OffersScreen());
                    },
                    child: const Row(
                      children: [
                        Text(
                          "VIEW ALL",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xff0D2949),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              heightSizedBox(10.0),
              GridView.builder(
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
                  })
            ],
          )
        );
      },
      error: (error, stackTrace) {
        log("Error in TopOffers: $error");
        return const Text("Something went wrong");
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}



class BrandDetail {
  final String id;
  final String title;
  final String description;
  final String logo;
  final String redirectLink;
  final List<dynamic> stores;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  BrandDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.logo,
    required this.redirectLink,
    required this.stores,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory BrandDetail.fromJson(Map<String, dynamic> json) {
    return BrandDetail(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      logo: json['logo'],
      redirectLink: json['redirect_link'],
      stores: json['stores'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}





// class Categories extends StatelessWidget {
//   const Categories({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const Padding(
//       padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Categories",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//           ),
//           HomeProdPage()
//         ],
//       ),
//     );
//   }
// }