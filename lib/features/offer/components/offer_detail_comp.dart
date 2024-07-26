import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/colors.dart';
import '../../../utils/sizes.dart';
import '../../brand/screens/brands.dart';

class AddressContainer extends StatelessWidget {
  final dynamic data;
  const AddressContainer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/images/location.svg'),
              widthSizedBox(10.0),
              Expanded(
                child: Text(
                  "${data['offer']['location']}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(color: Color(0xff7D7D7D)),
                ),
              ),
            ],
          ),
          heightSizedBox(10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/images/time.svg'),
              widthSizedBox(10.0),
              Expanded(
                child: Text(
                  formatDate("${data['offer']['expires_in']}"),
                  style: const TextStyle(color: Color(0xff7D7D7D)),
                ),
              ),
            ],
          ),
          heightSizedBox(10.0),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     SvgPicture.asset('assets/images/rupees.svg'),
          //     widthSizedBox(10.0),
          //     Expanded(
          //       child: Text(
          //         '${data['discount_value']}',
          //         style: const TextStyle(color: Color(0xff7D7D7D)),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  final dynamic data;
  const TopContainer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    log("date1${data}");

    log("expire1${data['offer']['expires_in']}");
    log("image1${data['offer']['image']}");
    log("description${data['offer']['description']}");
    return Container(
      height: null,
      width: 393,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Expires On : "),
                Text(
                  formatDate("${data['offer']['expires_in']}"),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, color: AppColor.btnColor),
                ),
              ],
            ),
            heightSizedBox(10.0),
            Center(
              child: Image.network(
                filterQuality: FilterQuality.high,
                // color: Colors.white,
                data['offer']['image'],
                height: 150,
                width: 200,
                fit: BoxFit.contain,
              ),
            ),
            heightSizedBox(10.0),
            Text("${data["offer"]['description']}")
          ],
        ),
      ),
    );
  }
}

class BrandComp extends StatelessWidget {
  final dynamic data;
  const BrandComp({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Brand",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BrendsLogoCard(
                src: '${data["offer"]['brand']['logo']}',
              ),
              widthSizedBox(10.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data["offer"]['brand']['title']}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff133964),
                      ),
                    ),
                    Text(
                      "${data["offer"]['brand']['description']}",
                      style: const TextStyle(
                          color: Color(0xff7D7D7D), fontSize: 12, height: 1.2),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    heightSizedBox(10.0),
                    SizedBox(
                      height: 30,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff0D2949)),
                          onPressed: () async {
                            final Uri redirectLink = Uri.parse(
                                "${data["offer"]['brand']['redirect_link']}");
                            if (await canLaunchUrl(redirectLink)) {
                              await launchUrl(redirectLink);
                            } else {
                              throw 'Could not launch $redirectLink';
                            }

                            // navigationPush(context,
                            //     BrandsDetails(id: data['brand']['_id']));
                          },
                          child: const Text(
                            "Visit Brand’s page",
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
