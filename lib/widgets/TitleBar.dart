import 'package:flutter/material.dart';
class TitleBar extends StatelessWidget {
  const TitleBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'FOREX',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff0531ff),
          ),
        ),
        Text(
          'TAINMENT',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xffff4d00),
          ),
        )
      ],
    );
  }
}
