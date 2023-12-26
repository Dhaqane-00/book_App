import 'package:book_grocer/services/api.dart';
import 'package:flutter/material.dart';

class Addbook extends StatefulWidget {
  const Addbook({super.key});

  @override
  State<Addbook> createState() => _AddbookState();
}

class _AddbookState extends State<Addbook> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController txtBook = TextEditingController();
  TextEditingController txtAuthor = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtimage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: 600,
        width: 600,
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              height: 50,
              width: 400,
              child: Text(
                "Add Book",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                        width: 2, color: Colors.greenAccent), //<-- SEE HERE
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
                        width: 2, color: Colors.greenAccent), //<-- SEE HERE
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
            Padding(
              padding: EdgeInsets.only(left: 13, right: 13),
              child: TextFormField(
                controller: txtDescription,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Colors.greenAccent), //<-- SEE HERE
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  hintText: "Enter Book description",
                  prefixIcon: Icon(
                    Icons.description_rounded,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Book description';
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
                controller: txtimage,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Colors.greenAccent), //<-- SEE HERE
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
              height: 15,
            ),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      child: Text("Add"),
                      style: ElevatedButton.styleFrom(fixedSize: Size(140, 50)),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          var Data = {
                            "name": txtBook.text,
                            "Author": txtAuthor.text,
                            "description": txtDescription.text,
                            "image": txtimage.text
                          };
                          Api.AddBook(Data);
                        }
                        ;
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      child: Text("Cancel"),
                      style: ElevatedButton.styleFrom(fixedSize: Size(140, 50)),
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
}
