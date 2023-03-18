import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebookapp/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/userrepo.dart';
import '../helpers/categorydetailscontroller.dart';
import '../helpers/featurescontroller.dart';
import '../helpers/homecontroller.dart';

class CategoryDetails extends StatefulWidget {
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  final controller = Get.put(CategoryDetailsController());
  final UserRepoController ctrl = Get.find();
  final homectl = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getGenreDetails(Get.arguments[0]).then((value) {});
  }

  Widget _image(String asset) {
    return Image.asset(
      asset,
      height: 30.0,
      width: 30.0,
      color: Colors.amber,
    );
  }

  @override
  Widget build(context) => GetBuilder<CategoryDetailsController>(
      builder: (_) => Scaffold(
          backgroundColor: primaryColor,
          body: SizedBox(
            height: getHeight(context),
            child: SafeArea(
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
                            onTap: () => Get.back(),
                            child: const Icon(Icons.arrow_back_ios,
                                color: Colors.white)),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          Get.arguments[1],
                          style: titleText4.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32))),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          // Card(
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(18),
                          //   ),
                          //   elevation: 1,
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(10.0),
                          //     child: Row(
                          //       children: [
                          //         Text(
                          //           "Search here",
                          //           style: subtitle1,
                          //         ),
                          //         const Spacer(),
                          //         const Icon(Icons.search)
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Card(
                            margin: const EdgeInsets.all(10).copyWith(top: 5),
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            child: Center(
                              child: TextFormField(
                                cursorColor: primaryColor,
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.raleway(
                                    fontSize: 18, color: primaryColor),
                                controller: _.searchController,
                                onChanged: (value) {
                                  _.updateSearchQuery(value);
                                  if (value.isNotEmpty) {
                                    _.updateissearching(true);
                                  } else {
                                    _.updateissearching(false);
                                  }
                                },
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(32))),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.black87,
                                  ),
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  counterText: "",
                                  contentPadding: const EdgeInsets.all(12),
                                  hintText: "Search Here",
                                  hintStyle: GoogleFonts.raleway(
                                      color: primaryColor, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (_.genrelist != null)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _.filteredbooklists.length,
                              itemBuilder: (context, index) => Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 3,
                                child: InkWell(
                                  onTap: () {
                                    homectl.selectedBookList =
                                        _.filteredbooklists[index];
                                    Get.toNamed('/bookdetails', arguments: [
                                      Get.arguments[0],
                                      Get.arguments[1]
                                    ]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Row(
                                      children: [
                                        CachedNetworkImage(
                                          height: 70,
                                          width: 70,
                                          imageUrl: imageUrl +
                                              _.filteredbooklists[index].photo,
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
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _.filteredbooklists[index].title,
                                              style: subtitle3.copyWith(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            // Padding(
                                            // padding:
                                            //     const EdgeInsets.all(8.0).copyWith(top: 0),
                                            // child:
                                            //     Html(
                                            //       data: _.genrelist!.booklists[index].introduction)),
                                            Text(
                                              ctrl.removeAllHtmlTags(_
                                                  .filteredbooklists[index]
                                                  .introduction),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: subtitle3.copyWith(
                                                  color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            if (_.filteredbooklists[index]
                                                    .booktags !=
                                                null)
                                              SizedBox(
                                                  width: getWidth(context),
                                                  height: 25,
                                                  child: SingleChildScrollView(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: ListView.builder(
                                                        itemCount: _
                                                            .filteredbooklists[
                                                                index]
                                                            .booktags!
                                                            .length,
                                                        itemBuilder:
                                                            (context, ind) =>
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      right: 8),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      color:
                                                                          primaryColor),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets.all(
                                                                            4.0)
                                                                        .copyWith(
                                                                            left:
                                                                                8,
                                                                            right:
                                                                                8),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        _
                                                                            .filteredbooklists[index]
                                                                            .booktags![ind]!
                                                                            .name!,
                                                                        style: smallText.copyWith(
                                                                            color:
                                                                                Colors.white),
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

                                            // Row(
                                            //   children: [
                                            //     Container(
                                            //       decoration: BoxDecoration(
                                            //           borderRadius:
                                            //               BorderRadius.circular(20),
                                            //           color: primaryColor),
                                            //       child: Padding(
                                            //         padding:
                                            //             const EdgeInsets.all(4.0),
                                            //         child: Text(
                                            //           "History",
                                            //           style: smallText.copyWith(
                                            //               color: Colors.white),
                                            //         ),
                                            //       ),
                                            //     ),
                                            //     const SizedBox(
                                            //       width: 8,
                                            //     ),
                                            //     Container(
                                            //       decoration: BoxDecoration(
                                            //           borderRadius:
                                            //               BorderRadius.circular(20),
                                            //           color: primaryColor),
                                            //       child: Padding(
                                            //         padding:
                                            //             const EdgeInsets.all(4.0),
                                            //         child: Text(
                                            //           "Comedy",
                                            //           style: smallText.copyWith(
                                            //               color: Colors.white),
                                            //         ),
                                            //       ),
                                            //     ),
                                            //     const Spacer(),
                                            //     RatingBar(
                                            //       initialRating: 3,
                                            //       itemSize: 10,
                                            //       direction: Axis.horizontal,
                                            //       allowHalfRating: true,
                                            //       itemCount: 5,
                                            //       ratingWidget: RatingWidget(
                                            //         full:
                                            //             _image('assets/heart.png'),
                                            //         half: _image(
                                            //             'assets/heart_half.png'),
                                            //         empty: _image(
                                            //             'assets/heart_border.png'),
                                            //       ),
                                            //       itemPadding: EdgeInsets.symmetric(
                                            //           horizontal: 1.0),
                                            //       onRatingUpdate: (rating) {
                                            //         print(rating);
                                            //       },
                                            //     )
                                            //   ],
                                            // ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          else
                            const SizedBox(
                              height: 60,
                              width: 60,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                  strokeWidth: 5,
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
          )));
}
