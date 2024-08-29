import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/home/repo/home_repo.dart';
import 'package:rush/utils/button.dart';
import 'package:rush/utils/fields.dart';
import 'package:rush/utils/sizes.dart';
import '../../../utils/colors.dart';

final ratingProvider = StateProvider<double>((ref) {
  return 1.0;
});

class RatingPage extends ConsumerWidget {
  RatingPage({super.key});

  TextEditingController ratingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rating = ref.watch(ratingProvider);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.appbarColor,
        foregroundColor: Colors.white,
        title: const Text("Rate us"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width(context),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 15,
                      bottom: 20,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Rate Us",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        heightSizedBox(5.0),
                        const Text(
                          "How would you love this app?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        heightSizedBox(10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              initialRating: 1,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 35,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                ref.read(ratingProvider.notifier).state =
                                    rating;
                              },
                            ),
                          ],
                        ),
                        heightSizedBox(25.0),
                        TxtField(maxLines: 5, controller: ratingController),
                        heightSizedBox(10.0),
                        Btn(
                          text: "Submit",
                          onPressed: () async {
                            await ref.read(homeRepoProvider).postRating(
                                comment: ratingController.text, rating: rating);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
