import 'package:book_grocer/wishlist/wishlist.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 18),
              width: 600,
              child: const Text(
                "Shoping Cart",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              margin: const EdgeInsets.all(60),
              width: 600,
              child: Image.asset("assets/img/Card.png"),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              height: 100,
              width: 600,
              child: const Text("Your Shoping Cart is Empty",
                  style: TextStyle(color: Colors.black54, fontSize: 15)),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              width: 600,
              child: const Text(
                  "Unfortunately, There are no items in your cart",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: 5, right: 20, bottom: 5),
                  width: 600,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    child: const Text(
                      "Go Wishlist",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (e) => const Wishlist(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
