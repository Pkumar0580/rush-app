import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/api_method.dart';
import '../../../utils/bottom_bar.dart';
import '../../../utils/colors.dart';
import '../../../utils/navigation.dart';
import 'brand_details.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  List<dynamic> data = [];
  List<dynamic> filteredData = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

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
    searchController.addListener(_filterData);
    fetchData((responseData) {
      setState(() {
        data = responseData;
        filteredData = responseData;
        isLoading = false;
      });
    });
  }

  void _filterData() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredData = data.where((brand) {
        final name = brand['title'].toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_filterData);
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
              icon: const Icon(Icons.arrow_back)),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
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
                    Expanded(
                      child: filteredData.isNotEmpty
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  MyBrandTabScreen(data: filteredData)
                                ],
                              ),
                            )
                          : const Center(
                              child: Text("No Data Available"),
                            ),
                    ),
                  ],
                ),
              ));
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
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10.0, // Spacing between columns
          mainAxisSpacing: 10.0, // Spacing between rows
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
          // height: 127,
          // width: 148,
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
