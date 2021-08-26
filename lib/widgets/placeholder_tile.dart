import 'package:flutter/material.dart';

class PlaceholderTile extends StatelessWidget {
  final double width;
  const PlaceholderTile({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            spreadRadius: 0.5,
            color: Colors.black45,
            blurRadius: 4,
            offset: Offset(1, 1))
      ], color: Colors.white70, borderRadius: BorderRadius.circular(25)),
      height: 35,
      width: width,
    );
  }
}
