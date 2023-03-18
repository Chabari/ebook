import 'package:ars_progress_dialog/dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebookapp/data/booklist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

import '../helpers/constants.dart';
import '../helpers/homecontroller.dart';

class SearchPage extends StatefulWidget {
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchEditingController = TextEditingController();
  final controller = Get.put(HomeController());
  List<BookList> booklists = [];
  bool istyping = false;
  String text = "No books available";
  String searchText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<BookList>> getProducts() async {
    var url = Uri.parse('${mainUrl}search-books');
    Map<String, dynamic> data = {'query': _searchEditingController.text};
    var response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          'Access-Control_Allow_Origin': '*'
        },
        body: data);
    print(response.body);
    return bookListFromJson(response.body);
  }

  void updateSearchQuery(String newQuery) {
    booklists.clear();
    setState(() {
      istyping = true;
      searchText = newQuery;
    });
    if (newQuery.length > 0) {
      getProducts().then((value) {
        setState(() {
          booklists = value;
          istyping = false;
        });
      });
    } else {
      setState(() {
        text = "Search for books here";
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SizedBox(
        height: getHeight(context),
        width: getWidth(context),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Card(
              margin: const EdgeInsets.all(10).copyWith(top: 5),
              elevation: 0,
              color: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: TextFormField(
                cursorColor: primaryColor,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                ),
                maxLength: 10,
                onChanged: (value) {
                  updateSearchQuery(value);
                  if (value.isEmpty) {
                    setState(() {
                      istyping = false;
                    });
                  }
                },
                controller: _searchEditingController,
                autofocus: true,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.0),
                      borderRadius: BorderRadius.all(Radius.circular(32))),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(32))),
                  prefixIcon: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.black,
                      )),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        searchText = '';
                        _searchEditingController.text = '';
                      });
                    },
                    child: Icon(
                      Icons.clear,
                      color: searchText.isNotEmpty
                          ? Colors.black
                          : Colors.grey.shade200,
                    ),
                  ),
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  counterText: "",
                  contentPadding: const EdgeInsets.all(12),
                  hintText: "Search here..",
                  hintStyle: GoogleFonts.montserrat(
                      color: Colors.black87, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            booklists.length > 0
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: booklists.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 3,
                        child: InkWell(
                          onTap: () {
                            controller.selectedBookList = booklists[index];
                            Get.toNamed('/bookdetails');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  height: 100,
                                  width: 80,
                                  imageUrl: imageUrl + booklists[index].photo,
                                  imageBuilder: (context, imageProvider) =>
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
                                          child: CircularProgressIndicator(
                                              color: primaryColor,
                                              value:
                                                  downloadProgress.progress)),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booklists[index].title,
                                      style: subtitle3.copyWith(),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${booklists[index].chapters} Chapters",
                                      style: subtitle2,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        if (booklists[index].booktags != null)
                                          SizedBox(
                                              width: 150,
                                              height: 25,
                                              child: SingleChildScrollView(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: ListView.builder(
                                                    itemCount: booklists[index]
                                                        .booktags!
                                                        .length,
                                                    itemBuilder: (context,
                                                            ind) =>
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 8),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              color:
                                                                  primaryColor),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                            .all(
                                                                        4.0)
                                                                    .copyWith(
                                                                        left: 8,
                                                                        right:
                                                                            8),
                                                            child: Center(
                                                              child: Text(
                                                                booklists[index]
                                                                    .booktags![
                                                                        ind]!
                                                                    .name!,
                                                                style: smallText
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .white),
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
                                            full: _image('assets/heart.png'),
                                            half:
                                                _image('assets/heart_half.png'),
                                            empty: _image(
                                                'assets/heart_border.png'),
                                          ),
                                          itemPadding: EdgeInsets.symmetric(
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
                  )
                : istyping
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
                          text,
                          style: GoogleFonts.montserrat(
                            color: Colors.grey,
                          ),
                        ),
                      ),
          ],
        )),
      ),
    );
  }

  Widget _image(String asset) {
    return Image.asset(
      asset,
      height: 30.0,
      width: 30.0,
      color: Colors.amber,
    );
  }
}
