import 'dart:convert';

import 'package:book_grocer/model/book_model.dart';
import 'package:http/http.dart' as http;

class Api {
  static const BaseUrl = "http://192.168.1.16:3000/books";

  static AddBook(Map bdata) async {
    print(bdata);
    var Url = Uri.parse(BaseUrl + "/AddBook");
    try {
      var res = await http.post(Url, body: bdata);

      if (res.statusCode == 200) {
        final Data = jsonDecode(res.body.toString());
        print(Data);
      } else {
        print("Failed to get reposnse. Code : ${res.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<List<BookModel>> GetBooks() async {
    List<BookModel> books = [];

    var url = Uri.parse(BaseUrl + "/GetBooks");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        for (var value in data["book"]) {
          books.add(BookModel(
            name: value["name"],
            author: value["author"],
            image: value["image"],
          ));
        }

        return books;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
