import 'package:flutter/material.dart';

class Addbook extends StatefulWidget {
  const Addbook({super.key});

  @override
  State<Addbook> createState() => _AddbookState();
}

class _AddbookState extends State<Addbook> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Colors.greenAccent), //<-- SEE HERE
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                hintText: "Enter Book Name",
                prefixIcon: Icon(
                  Icons.person,
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
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Colors.greenAccent), //<-- SEE HERE
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                hintText: "Enter Book Name",
                prefixIcon: Icon(
                  Icons.person,
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
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Colors.greenAccent), //<-- SEE HERE
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                hintText: "Enter Book Name",
                prefixIcon: Icon(
                  Icons.person,
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
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Colors.greenAccent), //<-- SEE HERE
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                hintText: "Enter Book Name",
                prefixIcon: Icon(
                  Icons.person,
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
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    child: Text("Add"),
                    style: ElevatedButton.styleFrom(fixedSize: Size(140, 50)),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    child: Text("Cancel"),
                    style: ElevatedButton.styleFrom(fixedSize: Size(140, 50)),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
