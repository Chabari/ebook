import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebookapp/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../helpers/featurescontroller.dart';
import '../helpers/genrescontroller.dart';

class Genre extends StatefulWidget {
  _GenreState createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  final controller = Get.put(GenresController());

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
  Widget build(context) => GetBuilder<GenresController>(
      builder: (_) => Scaffold(
      backgroundColor: primaryColor,
      body: SizedBox(
        height: getHeight(context),
        width: getWidth(context),
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
                      "Genres",
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
                width: getWidth(context),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                         topRight: Radius.circular(32))),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      controller.genreslists.length > 0
                        ? GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.90,
                        ),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        itemCount: controller.genreslists.length,
                        itemBuilder: (BuildContext context, int index) => Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 3,
                          child: InkWell(
                            onTap: () => Get.toNamed('/categorydetails',
                                arguments: [controller.genreslists[index].id, controller.genreslists[index].name]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    height: 70,
                                    width: 70,
                                    imageUrl:
                                        imageUrl + controller.genreslists[index].photo!,
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
                                  
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.genreslists[index].name!,
                                    maxLines: 2,
                                    style: subtitle4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : _.isLoading ? const SizedBox(
                        height: 60,
                        width: 60,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                            strokeWidth: 5,
                          ),
                        ),
                      ) : Text("No Genres available", style: subtitle.copyWith(color: Colors.grey),),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),)
      );
}
