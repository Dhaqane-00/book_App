import 'dart:convert';
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
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
