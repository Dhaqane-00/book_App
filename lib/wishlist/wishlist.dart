import 'package:book_grocer/Cart/Cart.dart';
import 'package:book_grocer/wishlist/Card_wishlist.dart';
import 'package:flutter/material.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Wishlist",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_checkout_sharp),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (e) => const Cart(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Card_wishlist(
                    ImgUrl: "assets/img/2.jpg",
                    name: "War",
                    author: "Demisheles",
                    price: "\$70"),
                Card_wishlist(
                    ImgUrl: "assets/img/3.jpg",
                    name: "The Dissapearance ",
                    author: "Michael Rosen",
                    price: "\$90"),
              ],
            ),
            Row(
              children: [
                Card_wishlist(
                    ImgUrl: "assets/img/7.jpg",
                    name: "Fatherhood",
                    author: "Marcus Berkmann",
                    price: "\$60"),
                Card_wishlist(
                    ImgUrl: "assets/img/6.jpg",
                    name: "The Time Travellers ",
                    author: "Stride Lottie",
                    price: "\$50"),
              ],
            ),
            Row(
              children: [
                Card_wishlist(
                    ImgUrl: "assets/img/4.jpg",
                    name: "Paper",
                    author: "by Christopher ",
                    price: "\$60"),
                Card_wishlist(
                    ImgUrl: "assets/img/5.jpg",
                    name: "The little Tree",
                    author: "by Jake Arnott",
                    price: "\$70"),
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
