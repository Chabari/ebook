import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/userrepo.dart';
import '../helpers/constants.dart';
import '../helpers/homecontroller.dart';
import '../helpers/mainpanelcontroller.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(HomeController());
  final userRepo = Get.find<UserRepoController>();
  String selected = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getSuggested().then((value) {});
    controller.getPopularBooks().then((value) {});
  }

  Widget _image(String asset) {
    return Image.asset(
      asset,
      height: 30.0,
      width: 30.0,
      color: Colors.amber,
    );
  }

  void _showPopupMenu() async {
    await showMenu(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      position: const RelativeRect.fromLTRB(20, 70, 100, 100),
      items: [
        PopupMenuItem(
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: selected == "logout"
                      ? const Icon(Icons.radio_button_checked_outlined)
                      : const Icon(Icons.radio_button_off),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text("Logout"),
              ],
            ),
            value: "logout"),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value != null) {
        setState(() {
          selected = value;
        });

        if (value == 'logout') {
          SharedPreferences.getInstance().then((value) {
            setState(() {
              value.clear().then((value) {
                Get.offNamed('/login');
              });
            });
          });
        }
      }
    });
  }

  @override
  Widget build(context) => GetBuilder<HomeController>(
      builder: (_) => Scaffold(
            backgroundColor: primaryColor,
            body: SizedBox(
              height: getHeight(context),
              width: getWidth(context),
              child: SafeArea(
                  child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              _showPopupMenu();
                            },
                            child: const Icon(Icons.menu)),
                          const Spacer(),
                          Text(
                            "Welcome ${userRepo.getUserName().split(' ')[0]}",
                            style: titleText4,
                          ),
                          const Spacer(),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                  image:
                                      AssetImage("assets/images/usericon.png")),
                              border: Border.all(color: primaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 1,
                      child: InkWell(
                        onTap: () => Get.toNamed('/searchpage'),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text(
                                "Search here",
                                style: subtitle1,
                              ),
                              const Spacer(),
                              const Icon(Icons.search)
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Stack(
                            children: [
                              CarouselSlider(
                                items: _.imageSliders,
                                carouselController: _.controllerCorosel,
                                options: CarouselOptions(
                                    autoPlay: true,
                                    //enlargeCenterPage: true,
                                    viewportFraction: 1,
                                    aspectRatio: 1.7,
                                    onPageChanged: (index, reason) {
                                      _.updateState(index);
                                    }),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      imgList.asMap().entries.map((entry) {
                                    return GestureDetector(
                                      onTap: () => _.controllerCorosel
                                          .animateToPage(entry.key),
                                      child: Container(
                                        width: 12.0,
                                        height: 12.0,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 4.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                (Theme.of(context).brightness ==
                                                            Brightness.dark
                                                        ? Colors.white
                                                        : Colors.black)
                                                    .withOpacity(
                                                        _.current == entry.key
                                                            ? 0.9
                                                            : 0.4)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Popular Now",
                                  style: subtitle.copyWith(color: Colors.grey),
                                ),
                                const Spacer(),
                                Text(
                                  "See All",
                                  style: subtitle.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 230,
                            width: getWidth(context),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _.booklists.length,
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        _.selectedBookList =
                                            _.suggestedbooklists[index];
                                        Get.toNamed('/bookdetails');
                                      },
                                      child: Column(
                                        children: [
                                          // Container(
                                          //   height: 180,
                                          //   width: 120,
                                          //   decoration: BoxDecoration(
                                          //       borderRadius:
                                          //           BorderRadius.circular(32),
                                          //       image: const DecorationImage(
                                          //           image: AssetImage(
                                          //               "assets/books/thelittlemamaid.png"))),
                                          // ),
                                          CachedNetworkImage(
                                            height: 180,
                                            width: 120,
                                            imageUrl: imageUrl +
                                                _.booklists[index].photo,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Container(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: primaryColor,
                                                            value:
                                                                downloadProgress
                                                                    .progress)),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            _.booklists[index].title,
                                            style: subtitle3.copyWith(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  // Row(
                                  //   children: [
                                  //     InkWell(
                                  //       onTap: () => Get.toNamed('/bookdetails'),
                                  //       child: Column(
                                  //         children: [
                                  //           Container(
                                  //             height: 180,
                                  //             width: 120,
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(32),
                                  //                 image: const DecorationImage(
                                  //                     image: AssetImage(
                                  //                         "assets/books/thelittlemamaid.png"))),
                                  //           ),
                                  //           const SizedBox(
                                  //             height: 8,
                                  //           ),
                                  //           Text(
                                  //             "The little mermaid",
                                  //             style: subtitle3.copyWith(),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     const SizedBox(
                                  //       width: 10,
                                  //     ),
                                  //     InkWell(
                                  //       onTap: () => Get.toNamed('/bookdetails'),
                                  //       child: Column(
                                  //         children: [
                                  //           Container(
                                  //             height: 180,
                                  //             width: 120,
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(32),
                                  //                 image: const DecorationImage(
                                  //                     image: AssetImage(
                                  //                         "assets/books/thecryingbook.png"))),
                                  //           ),
                                  //           const SizedBox(
                                  //             height: 8,
                                  //           ),
                                  //           Text(
                                  //             "The Crying Book",
                                  //             style: subtitle3.copyWith(),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     const SizedBox(
                                  //       width: 10,
                                  //     ),
                                  //     InkWell(
                                  //       onTap: () => Get.toNamed('/bookdetails'),
                                  //       child: Column(
                                  //         children: [
                                  //           Container(
                                  //             height: 180,
                                  //             width: 120,
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(32),
                                  //                 image: const DecorationImage(
                                  //                     image: AssetImage(
                                  //                         "assets/books/mybook.png"))),
                                  //           ),
                                  //           const SizedBox(
                                  //             height: 8,
                                  //           ),
                                  //           Text(
                                  //             "Tools of Titans",
                                  //             style: subtitle3.copyWith(),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Suggested for you",
                                  style: subtitle.copyWith(color: Colors.grey),
                                ),
                                const Spacer(),
                                Text(
                                  "See All",
                                  style: subtitle.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: _.suggestedbooklists.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 3,
                              child: InkWell(
                                onTap: () {
                                  _.selectedBookList =
                                      _.suggestedbooklists[index];
                                  Get.toNamed('/bookdetails');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        height: 100,
                                        width: 80,
                                        imageUrl: imageUrl +
                                            _.suggestedbooklists[index].photo,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Container(
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: primaryColor,
                                                        value: downloadProgress
                                                            .progress)),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _.suggestedbooklists[index].title,
                                            style: subtitle3.copyWith(),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${_.suggestedbooklists[index].chapters} Chapters",
                                            style: subtitle2,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              if (_.suggestedbooklists[index]
                                                      .booktags !=
                                                  null)
                                                SizedBox(
                                                    width: 150,
                                                    height: 25,
                                                    child:
                                                        SingleChildScrollView(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: ListView.builder(
                                                          itemCount: _
                                                              .suggestedbooklists[
                                                                  index]
                                                              .booktags!
                                                              .length,
                                                          itemBuilder:
                                                              (context, ind) =>
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            8),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                20),
                                                                        color:
                                                                            primaryColor),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets.all(4.0).copyWith(
                                                                          left:
                                                                              8,
                                                                          right:
                                                                              8),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          _.suggestedbooklists[index].booktags![ind]!
                                                                              .name!,
                                                                          style:
                                                                              smallText.copyWith(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          shrinkWrap: true,
                                                          physics:
                                                              const NeverScrollableScrollPhysics()),
                                                    )),
                                              const Spacer(),
                                              RatingBar(
                                                initialRating: 4.5,
                                                direction: Axis.horizontal,
                                                itemSize: 15,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                ratingWidget: RatingWidget(
                                                  full: _image(
                                                      'assets/heart.png'),
                                                  half: _image(
                                                      'assets/heart_half.png'),
                                                  empty: _image(
                                                      'assets/heart_border.png'),
                                                ),
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 1.0),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ))
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(20),
                    //               color: primaryColor),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0).copyWith(left: 12, right: 12),
                    //             child: Text(
                    //               "Explore",
                    //               style: subtitle3.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    //             ),
                    //           )),
                    //       Container(
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(20),
                    //               color: Colors.white),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0).copyWith(left: 12, right: 12),
                    //             child: Text(
                    //               "Reccent",
                    //               style: subtitle3.copyWith( fontWeight: FontWeight.bold),
                    //             ),
                    //           )),
                    //       Container(
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(20),
                    //               color: Colors.white),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0).copyWith(left: 12, right: 12),
                    //             child: Text(
                    //               "New",
                    //               style: subtitle3.copyWith(fontWeight: FontWeight.bold),
                    //             ),
                    //           )),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              )),
            ),
          ));
}
