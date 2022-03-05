import 'package:flutter/material.dart';

/// 0 1 2
/// 3 4 5
/// 6 7 8


class TileWidget extends StatefulWidget {
  const TileWidget({Key? key, required this.i}) : super(key: key);

  final int i;

  @override
  _TileWidgetState createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> {
  String j = "";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        j = 'X';
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: (widget.i != 2 && widget.i != 5 && widget.i != 8)
                ? BorderSide(
              color: Color(0xFF0BA192),
              width: 5,
            )
                : BorderSide(color: Colors.transparent),
            bottom: widget.i < 6
                ? BorderSide(
              color: Color(0xFF0BA192),
              width: 5,
            )
                : BorderSide(color: Colors.transparent),
          ),
        ),
        child: Center(child: Text(j)),
      ),
    );
  }
}
