import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebookapp/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/userrepo.dart';
import '../helpers/featurescontroller.dart';
import '../helpers/homecontroller.dart';

class Featured extends StatefulWidget {
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  final controller = Get.put(FeaturesController());
  final homectl = Get.put(HomeController());
  final UserRepoController ctrl = Get.find();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (controller.genreslists.length < 1) {
      controller.getfeatured().then((value) {
      });
    }
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
  Widget build(context) => GetBuilder<FeaturesController>(
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
                        const Icon(Icons.arrow_back_ios, color: Colors.white),
                        Text(
                          "Featured",
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
                            height: 20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: 80,
                                    height: getHeight(context),
                                    padding: const EdgeInsets.only(bottom: 30),
                                    
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: _.genreslists.length,
                                        padding: const EdgeInsets.only(bottom: 250),
                                      physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) => InkWell(
                                            onTap: () => _.setGenre(_.genreslists[index]),
                                            child: Container(
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  color: _.selectedGenre != null && _.selectedGenre!.id == _.genreslists[index].id
                                                      ? Colors.grey.shade200
                                                      : Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    CachedNetworkImage(
                                                      height: 60,
                                                      width: 70,
                                                      imageUrl:
                                                          imageUrl + _.genreslists[index].photo!,
                                                      imageBuilder: (context, imageProvider) => Container(
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      progressIndicatorBuilder:
                                                          (context, url, downloadProgress) => Container(
                                                        alignment: Alignment.center,
                                                        child: SizedBox(
                                                          height: 50,
                                                          width: 50,
                                                          child: Center(
                                                              child: CircularProgressIndicator(
                                                                  color: primaryColor,
                                                                  value: downloadProgress.progress)),
                                                        ),
                                                      ),
                                                      errorWidget: (context, url, error) =>
                                                          const Icon(Icons.error),
                                                    ),
                                                    Text(
                                                      _.genreslists[index].name!,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: subtitle4,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          ) 
                                    )),
                                Container(
                                  width: 6,
                                  height: getHeight(context),
                                  color: Colors.grey.shade200,
                                ),
                                Expanded(
                                    child: Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 170),
                                        //height: getHeight(context),
                                        child: _.selectedGenre !=null && _.selectedGenre!.booklists.length > 0 ? ListView.builder(
                                          shrinkWrap: true,
                                          physics: const BouncingScrollPhysics(),
                                          itemCount: _.selectedGenre!.booklists.length,
                                          itemBuilder: (context, index) => Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              elevation: 3,
                                              child: InkWell(
                                                onTap: () {

                                                    homectl.selectedBookList = _.selectedGenre!.booklists[index];
                                                    Get.toNamed('/bookdetails');
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          6.0),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 90,
                                                        width: 70,
                                                        decoration:  BoxDecoration(
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    imageUrl + _.selectedGenre!.booklists[index].photo))),
                                                      ),
                                                      Expanded(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            _.selectedGenre!.booklists[index].title,
                                                            style: subtitle3.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),

                                                          Text(
                                                            ctrl.removeAllHtmlTags(
                                                              _.selectedGenre!.booklists[index].introduction),
                                                           
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: subtitle3
                                                                .copyWith(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          
                                                          
                                            
                                                          Row(
                                                            children: [
                                                              // Container(
                                                              //   decoration: BoxDecoration(
                                                              //       borderRadius:
                                                              //           BorderRadius.circular(
                                                              //               20),
                                                              //       color:
                                                              //           primaryColor),
                                                              //   child:
                                                              //       Padding(
                                                              //     padding:
                                                              //         const EdgeInsets.all(
                                                              //             4.0),
                                                              //     child: Text(
                                                              //       "History",
                                                              //       style: smallText.copyWith(
                                                              //           color:
                                                              //               Colors.white),
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                              // const SizedBox(
                                                              //   width: 8,
                                                              // ),
                                                              // Container(
                                                              //   decoration: BoxDecoration(
                                                              //       borderRadius:
                                                              //           BorderRadius.circular(
                                                              //               20),
                                                              //       color:
                                                              //           primaryColor),
                                                              //   child:
                                                              //       Padding(
                                                              //     padding:
                                                              //         const EdgeInsets.all(
                                                              //             4.0),
                                                              //     child: Text(
                                                              //       "Comedy",
                                                              //       style: smallText.copyWith(
                                                              //           color:
                                                              //               Colors.white),
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                              
                                                              if (_.selectedGenre!.booklists[index].booktags != null)
                                                          
                                                                  SizedBox(
                                                                      width: 120,
                                                                      height: 25,
                                                                      child: SingleChildScrollView(
                                                                        physics:
                                                                            const BouncingScrollPhysics(),
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        child: ListView.builder(
                                                                            itemCount: _.selectedGenre!.booklists[index].booktags!
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
                                                                                            _.selectedGenre!.booklists[index]
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
                                                              
                                                              
                                                              const Spacer(),
                                                              RatingBar(
                                                                initialRating:
                                                                    3,
                                                                itemSize: 10,
                                                                direction: Axis
                                                                    .horizontal,
                                                                allowHalfRating:
                                                                    true,
                                                                itemCount: 5,
                                                                ratingWidget:
                                                                    RatingWidget(
                                                                  full: _image(
                                                                      'assets/heart.png'),
                                                                  half: _image(
                                                                      'assets/heart_half.png'),
                                                                  empty: _image(
                                                                      'assets/heart_border.png'),
                                                                ),
                                                                itemPadding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            1.0),
                                                                onRatingUpdate:
                                                                    (rating) {
                                                                  print(
                                                                      rating);
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
                                            )
                                            : _.isLoading
                                            ? const SizedBox(
                                                height: 60,
                                                width: 60,
                                                child: Center(
                                                  child: CircularProgressIndicator(
                                                    color: primaryColor,
                                                    strokeWidth: 5,
                                                  ),
                                                ),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Text(
                                                  _.selectedGenre != null
                                                      ? "No ${_.selectedGenre!.name} books Available"
                                                      : "No Books Available",
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                      ) 
                                      )
                              ])
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
          )
        )
      );
}
