import 'package:flutter/material.dart';
class Bat extends StatelessWidget {
  final double width;
  final double height;
  Bat(this.height,this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.cyan[200],
          width: 1
        ),
        gradient: LinearGradient(
          colors: [Colors.white,Colors.cyan[100],]
        )
      ),

    );
  }
}
