import 'package:flutter/material.dart';

class ScoreCardWidget extends StatelessWidget {
  const ScoreCardWidget({
    Key? key,
    required this.text,
    required this.point,
  }) : super(key: key);

  final String text;
  final int point;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFF0BA192),
          width: 3,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              )),
          Text("$point",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}