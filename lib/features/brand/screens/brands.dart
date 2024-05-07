
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/api_method.dart';
import '../../../utils/colors.dart';
import '../../../utils/navigation.dart';
import '../../offer/screens/offers_screen.dart';
import 'brand_details.dart';


// final getBrendProvider = FutureProvider((ref) async {
//   return await ref.watch(brandRepoProvider).getBrands();
// });

// class BrandScreen extends ConsumerWidget {
//   BrandScreen({super.key});

//   List<dynamic> data = [];

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final getdata = ref.watch(getBrendProvider);

//     log("dataaaaaaaaaaaaaaaaa=> ${getdata}");

//     return SafeArea(
//         child: Scaffold(
//             backgroundColor: AppColor.backgroundColor,
//             appBar: AppBar(
//               foregroundColor: Colors.white,
//               backgroundColor: AppColor.appbarColor,
//               title: const Text("Brands"),
//               automaticallyImplyLeading: true,
//             ),
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     height: 100,
//                     width: double.infinity,
//                     decoration: const BoxDecoration(
//                       color: Color(0xff204571),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           top: 30, bottom: 30.0, left: 10.0, right: 10.0),
//                       child: SizedBox(
//                         height: 40,
//                         child: CupertinoSearchTextField(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(21)),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SingleChildScrollView(
//                     child: Column(
//                         children: [MyBrandTabScreen(data: data)],
//                         ),
//                   )
//                 ],
//               ),
//             ),),);
//   }
// }

// class MyBrandTabScreen extends StatelessWidget {
//   final data;
//   const MyBrandTabScreen({
//     super.key,
//     this.data,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, // Number of columns
//           crossAxisSpacing: 10.0, // Spacing between columns
//           mainAxisSpacing: 10.0, // Spacing between rows
//         ),
//         itemCount: data.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding:
//                 const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
//             child: BrendsLogoCard(
//               src: data[index]['logo'],
//               onTap: () {
//                 navigationPush(
//                     context,
//                     BrandsDetails(
//                       id: data[index]["_id"],
//                     ));
//               },
//             ),
//           );
//         });
//   }
// }












class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  List<dynamic> data = [];

  @override
  void initState() {
    fetchData((responseData) {
   
      setState(() {
        data = responseData;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.backgroundColor,
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: AppColor.appbarColor,
            title: const Text("Brands"),
            automaticallyImplyLeading: true,
          ),
          body: data.isNotEmpty
              ? SingleChildScrollView(
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
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(21)),
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [MyBrandTabScreen(data: data)],
                        ),
                      )
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )),
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
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10.0, // Spacing between columns
          mainAxisSpacing: 10.0, // Spacing between rows
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: BrendsLogoCard(
              src: data[index]['logo'],
              onTap: () {
                navigationPush(
                    context,
                    BrandsDetails(
                      id: data[index]["_id"],
                    ));
              },
            ),
          );
        });
    
  }
}


