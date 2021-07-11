import 'package:flutter/material.dart';
class Ball extends StatelessWidget {
  final double dim=50;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: dim,
      height: dim,
      decoration: new BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.cyan[50],Colors.cyan[200],Colors.black38,]
        ),
        shape: BoxShape.circle
      ),
    );
  }
}
