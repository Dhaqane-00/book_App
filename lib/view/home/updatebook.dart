import 'dart:convert';

import 'package:book_grocer/model/book_model.dart';
import 'package:book_grocer/services/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:book_grocer/model/book_model.dart';
import 'package:http/http.dart' as http;

class UpdateBook extends StatefulWidget {
  const UpdateBook({Key? key}) : super(key: key);

  @override
  State<UpdateBook> createState() => _UpdateBookState();
}

class _UpdateBookState extends State<UpdateBook> {
  List<BookModel> books = [];

  Future<List<BookModel>> getbooks() async {
    try {
      books.clear();
      var response = await http
          .get(Uri.parse("http://192.168.172.85:3000/books/GetBooks"));

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

  final _formKey = GlobalKey<FormState>();

  TextEditingController txtBook = TextEditingController();
  TextEditingController txtAuthor = TextEditingController();
  TextEditingController txtImage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookModel>>(
      future: getbooks(), // Fetch data when the widget is created
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator while data is being fetched
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No books found');
        } else {
          // Pre-fill form fields with existing book data
          txtBook.text = snapshot.data![0].name.toString();
          txtAuthor.text = snapshot.data![0].author.toString();
          txtImage.text = snapshot.data![0].image.toString();

          return Form(
            key: _formKey,
            child: Container(
              height: 500,
              width: 600,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 50,
                    width: 400,
                    child: Text(
                      "Update Book",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 13, right: 13),
                    child: TextFormField(
                      controller: txtBook,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Colors.greenAccent), //<-- SEE HERE
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        hintText: "Enter Book Name",
                        prefixIcon: Icon(
                          Icons.book_outlined,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Book name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 13, right: 13),
                    child: TextFormField(
                      controller: txtAuthor,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Colors.greenAccent), //<-- SEE HERE
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        hintText: "Enter Book Author",
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Book Author name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 13, right: 13),
                    child: TextFormField(
                      controller: txtImage,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Colors.greenAccent), //<-- SEE HERE
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        hintText: "Enter image As Link",
                        prefixIcon: Icon(
                          Icons.image,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Book iamge';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            child: Text("Update"),
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(140, 50)),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {}
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            child: Text("Cancel"),
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(140, 50)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
