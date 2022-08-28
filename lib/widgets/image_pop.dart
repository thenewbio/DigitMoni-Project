import 'package:flutter/material.dart';

class ImageDesc extends StatelessWidget {
  final String image;
  const ImageDesc({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
            Hero(
              tag: 'postUrl',
              child: Container(
                margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                height: MediaQuery.of(context).size.height * 0.67,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
