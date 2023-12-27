import 'dart:io';

import 'package:book_grocer/view/account/addBook.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/color_extenstion.dart';
import '../../common_widget/your_review_row.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  String imagePath = ''; // To store the selected image path

  _selectFile(bool imageFrom) async {
    final picker = ImagePicker();
    var pickedFile = await picker.pickImage(
        source: imageFrom ? ImageSource.gallery : ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path; // Store the selected image path
      });
      print(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  List purArr = ["assets/img/p1.jpg", "assets/img/p2.jpg", "assets/img/p3.jpg"];

  List sResultArr = [
    {
      "img": "assets/img/p1.jpg",
      "description":
          "A must read for everybody. This book taught me so many things about...",
      "rate": 5.0
    },
    {
      "img": "assets/img/p2.jpg",
      "description":
          "#1 international bestseller and award winning history book.",
      "rate": 4.0
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
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: TColor.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentUser.email!,
                          style: TextStyle(
                              color: TColor.text,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Constantly travelling and keeping up to date with business related books.",
                          style:
                              TextStyle(color: TColor.subTitle, fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: imagePath.isNotEmpty
                          ? Image.file(
                              File(imagePath),
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/img/u1.png",
                              width: 70,
                              height: 70,
                            )),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Icon(
                    Icons.near_me_sharp,
                    color: TColor.subTitle,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: Text(
                    "Newcastle - Australia",
                    style: TextStyle(color: TColor.subTitle, fontSize: 13),
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    height: 30.0,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: TColor.button),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: TColor.primary,
                            blurRadius: 2,
                            offset: const Offset(0, 2),
                          )
                        ]),
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 120,
                                child: ListView(
                                  children: [
                                    ListTile(
                                      leading: const Icon(
                                        CupertinoIcons.photo_on_rectangle,
                                      ),
                                      title: const Text('Galery'),
                                      onTap: () {
                                        _selectFile(true);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                        CupertinoIcons.photo_camera_solid,
                                      ),
                                      title: const Text('Camera'),
                                      onTap: () {
                                        _selectFile(false);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "21",
                        style: TextStyle(
                            color: TColor.subTitle,
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Books",
                        style: TextStyle(color: TColor.subTitle, fontSize: 11),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "5",
                        style: TextStyle(
                            color: TColor.subTitle,
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Reviews",
                        style: TextStyle(color: TColor.subTitle, fontSize: 11),
                      )
                    ],
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            child: const Text("Add Book"),
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                context: context,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Addbook(),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text("Save Profile"),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Text(
                "Your purchases (21)",
                style: TextStyle(
                    color: TColor.subTitle,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: media.width * 0.4,
                  width: media.width * 0.45,
                  decoration: const BoxDecoration(
                      color: Color(0xffFF5957),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: purArr.map((iName) {
                      var isFirst = purArr.first == iName;
                      var isLast = purArr.last == iName;
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 12),
                        padding: isFirst
                            ? const EdgeInsets.only(left: 25)
                            : (isLast
                                ? const EdgeInsets.only(right: 25)
                                : null),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 2,
                                    offset: Offset(0, 1))
                              ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              iName,
                              height: media.width * 0.5,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Text(
                "Your reviews (7)",
                style: TextStyle(
                    color: TColor.subTitle,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                itemCount: sResultArr.length,
                itemBuilder: (context, index) {
                  var rObj = sResultArr[index] as Map? ?? {};
                  return YourReviewRow(sObj: rObj);
                })
          ],
        ),
      ),
    );
  }
}
