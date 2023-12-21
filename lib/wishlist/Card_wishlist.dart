import 'package:flutter/material.dart';

class Card_wishlist extends StatelessWidget {
  final String ImgUrl;
  final String name;
  final String author;
  final String price;

  const Card_wishlist({
    super.key,
    required this.ImgUrl,
    required this.name,
    required this.author,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 20),
      height: 300,
      width: 190,
      decoration: const BoxDecoration(
        color: Color(0xff5ABD8C),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  ImgUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 100,
              width: 200,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 4, left: 7),
                    height: 50,
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          author,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          price,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        const SizedBox(
                          width: 80,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
