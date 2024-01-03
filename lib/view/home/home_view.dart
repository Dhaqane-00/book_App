import 'dart:convert';
import 'dart:math';

import 'package:book_grocer/common/color_extenstion.dart';
import 'package:book_grocer/model/book_model.dart';
import 'package:book_grocer/view/account/addBook.dart';
import 'package:book_grocer/view/book_reading/book_reading_view.dart';
import 'package:book_grocer/view/home/updatebook.dart';
import 'package:book_grocer/view/onboarding/onboarding_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../common_widget/best_seller_cell.dart';
import '../../common_widget/genres_cell.dart';
import '../../common_widget/recently_cell.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';
import '../../common_widget/top_picks_cell.dart';
import '../login/sign_up_view.dart';
import '../main_tab/main_tab_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<BookModel> books = [];

  Future<List<BookModel>> getbooks() async {
    try {
      books.clear();
      var response =
          await http.get(Uri.parse("http://192.168.172.85/books/GetBooks"));

      if (response.statusCode == 200) {
        print(response.body);

        var json = jsonDecode(response.body);
        List data = json["data"];
        print(data.length);
        for (int i = 0; i < data.length; i++) {
          books.add(BookModel.fromJson(data[i]));
        }

        return books;
      }
    } catch (e) {
      print(e.toString());
    }

    return books;
  }

  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  List topPicksArr = [
    {
      "name": "The Dissapearance of Emila Zola",
      "author": "Michael Rosen",
      "img": "assets/img/1.jpg"
    },
    {
      "name": "Fatherhood",
      "author": "Marcus Berkmann",
      "img": "assets/img/2.jpg"
    },
    {
      "name": "The Time Travellers Handbook",
      "author": "Stride Lottie",
      "img": "assets/img/3.jpg"
    },
    {
      "name": "Fatherhood",
      "author": "by Christopher Wilson",
      "img": "assets/img/4.jpg"
    }
  ];

  List bestArr = [
    {
      "name": "Fatherhood",
      "author": "by Christopher Wilson",
      "img": "assets/img/4.jpg",
      "rating": 5.0
    },
    {
      "name": "In A Land Of Paper Gods",
      "author": "by Rebecca Mackenzie",
      "img": "assets/img/5.jpg",
      "rating": 4.0
    },
    {
      "name": "Tattletale",
      "author": "by Sarah J. Noughton",
      "img": "assets/img/6.jpg",
      "rating": 3.0
    }
  ];

  List genresArr = [
    {
      "name": "Graphic Novels",
      "img": "assets/img/g1.png",
    },
    {
      "name": "Graphic Novels",
      "img": "assets/img/g1.png",
    },
    {
      "name": "Graphic Novels",
      "img": "assets/img/g1.png",
    }
  ];

  List recentArr = [
    {
      "name": "The Fatal Tree",
      "author": "by Jake Arnott",
      "img": "assets/img/10.jpg"
    },
    {
      "name": "Day Four",
      "author": "by LOTZ, SARAH",
      "img": "assets/img/11.jpg"
    },
    {
      "name": "Door to Door",
      "author": "by Edward Humes",
      "img": "assets/img/12.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  child: Transform.scale(
                    scale: 1.5,
                    origin: Offset(0, media.width * 0.8),
                    child: Container(
                      width: media.width,
                      height: media.width,
                      decoration: BoxDecoration(
                          color: TColor.primary,
                          borderRadius:
                              BorderRadius.circular(media.width * 0.5)),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: Row(children: const [
                        Text(
                          "Our Top Picks",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700),
                        )
                      ]),
                      leading: Container(),
                      leadingWidth: 1,
                      actions: [
                        IconButton(
                            onPressed: () {
                              sideMenuScaffoldKey.currentState?.openEndDrawer();
                            },
                            icon: const Icon(Icons.menu))
                      ],
                    ),
                    SizedBox(
                      width: media.width,
                      height: media.width * 0.8,
                      child: CarouselSlider.builder(
                        itemCount: topPicksArr.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          var iObj = topPicksArr[itemIndex] as Map? ?? {};
                          return TopPicksCell(
                            iObj: iObj,
                          );
                        },
                        options: CarouselOptions(
                          autoPlay: false,
                          aspectRatio: 1,
                          enlargeCenterPage: true,
                          viewportFraction: 0.45,
                          enlargeFactor: 0.4,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            "Bestsellers",
                            style: TextStyle(
                                color: TColor.text,
                                fontSize: 22,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.9,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 8),
                          scrollDirection: Axis.horizontal,
                          itemCount: bestArr.length,
                          itemBuilder: ((context, index) {
                            var bObj = bestArr[index] as Map? ?? {};
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookReadingView(
                                            bObj: bObj,
                                          )),
                                );
                              },
                              child: BestSellerCell(
                                bObj: bObj,
                              ),
                            );
                          })),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(children: [
                        Text(
                          "Genres",
                          style: TextStyle(
                              color: TColor.text,
                              fontSize: 22,
                              fontWeight: FontWeight.w700),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: media.width * 0.6,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 8),
                          scrollDirection: Axis.horizontal,
                          itemCount: genresArr.length,
                          itemBuilder: ((context, index) {
                            var bObj = genresArr[index] as Map? ?? {};

                            return GenresCell(
                              bObj: bObj,
                              bgcolor: index % 2 == 0
                                  ? TColor.color1
                                  : TColor.color2,
                            );
                          })),
                    ),
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(children: [
                        Text(
                          "Recently Viewed",
                          style: TextStyle(
                              color: TColor.text,
                              fontSize: 22,
                              fontWeight: FontWeight.w700),
                        )
                      ]),
                    ),
                    GestureDetector(
                      onTap: () {
                        {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: UpdateBook(),
                              );
                            },
                          );
                        }
                      },
                      child: SizedBox(
                        height: media.width * 0.7,
                        child: FutureBuilder<List<BookModel>>(
                          future: getbooks(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  value:
                                      null, // Set to null for an indeterminate state
                                  strokeWidth: 5, // Set the stroke width
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue), // Set the color
                                  semanticsLabel:
                                      'Loading', // Set a label for accessibility
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Text('No books available.');
                            } else {
                              List<BookModel> books = snapshot.data!;
                              return ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 8),
                                scrollDirection: Axis.horizontal,
                                itemCount: books.length,
                                itemBuilder: (context, index) {
                                  var bObj = books[index];
                                  return RecentlyCell(
                                    iObj: bObj.toMap(),

                                    // Assuming iObj in RecentlyCell takes a Map
                                  );
                                  setState(() {});
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(children: [
                        Text(
                          "Monthly Newsletter",
                          style: TextStyle(
                              color: TColor.text,
                              fontSize: 22,
                              fontWeight: FontWeight.w700),
                        )
                      ]),
                    ),
                    Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                          color: TColor.textbox.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Receive our monthly newsletter and receive updates on new stock, books and the occasional promotion.",
                              style: TextStyle(
                                color: TColor.subTitle,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            RoundTextField(
                              controller: txtName,
                              hintText: "Name",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            RoundTextField(
                              controller: txtEmail,
                              hintText: "Email Address",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MiniRoundButton(
                                  title: "Sign Up",
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpView()));
                                  },
                                )
                              ],
                            )
                          ]),
                    ),
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
