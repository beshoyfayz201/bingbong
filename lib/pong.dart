import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'ball.dart';
import 'bat.dart';


enum dierction{up,down,right,left}

class Pong extends StatefulWidget {
  @override
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin{
  double height=0;
  double width=0;
  double posX=0;
  double posY=0;
  double batheight=0;
  double batwidth=0;
  double batpos=0;
  Animation <double>animation;
  AnimationController animationController;
  dierction vDir=dierction.down;
  dierction hDir=dierction.right;
  double increment=5;
  double randX,randY=1;
  int score=0;

  void checkBorders() {
    double diameter = 50;
    if (posX <= 0 && hDir == dierction.left)
    {        hDir = dierction.right;
    randX=randomNumber();
    }
    if (posX >= width - diameter && hDir == dierction.right)
    {
      hDir = dierction.left;
      randX=randomNumber();
    }
    if (posY >= height - diameter - batheight && vDir == dierction.down) {
      //check if the bat is here, otherwise loose
       if (posX >= (batpos - diameter) && posX <= (batpos +    batwidth + diameter))
       {
         vDir = dierction.up;
         randY=randomNumber();
         score++;
       }
       else {
         animationController.stop();
         showMassage(context) ;}}

    if (posY <= 0 && vDir == dierction.up)
    {
      vDir = dierction.down;
      randY=randomNumber();
    }

  }
  @override
  void initState() {
    posX=posY=0;
    animationController=AnimationController(duration: const Duration(
      minutes: 10000,
    ),vsync: this);

    animation=Tween(begin: 0.0,end: 100.0).animate(animationController);

    animation.addListener((){
      safeSetState(() {
        (vDir==dierction.up)?posY-=((increment*randY).round())
            :posY+=((increment*randY).round());
        (hDir==dierction.right)?posX+=((increment*randY).round())
            :posX-=((increment*randX).round());

      });
       checkBorders();
    });
    animationController.forward();
    super.initState();
  }


  void showMassage(BuildContext context){
    showDialog(context: context,
        builder:(BuildContext context){
          return new AlertDialog(
            title: Text("Game over"),
            content: Text("do you want to play again?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes"),
                onPressed: (){
                  setState(() {
                    posY=posX=0.0;
                    score=0;

                  });
                  Navigator.of(context).pop();
                  animationController.repeat();

                },

              ),
              FlatButton(child: Text("No"),
                onPressed: (){
                  Navigator.of(context).pop();
                  animationController.dispose();
                },
              )
            ],
          );
        });
  }



  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        height=constraints.maxHeight;
        width=constraints.maxWidth;
        batwidth=width/4;
        batheight=height/20;



        return Stack(
          children: <Widget>[
            Image.asset("images/aa.jpg",
            height:MediaQuery.of(context).size.height ,
            fit:
              BoxFit.fill,),
            Positioned(
              top: 0,
              right: 24,
              child: Text("Score : "+score.toString()),

            ),

            Positioned(child: Ball(), top: posY,
            left: posX,),
            Positioned(
              bottom: 0,
              left: batpos,
              child: GestureDetector(
                child: Bat(batheight, batwidth),
              onHorizontalDragUpdate:(DragUpdateDetails update)=>
                moveBat(update),),
            )
          ],
        );
      },
    );
  }
  moveBat(DragUpdateDetails updateDetails){
    safeSetState(() {

      batpos+=updateDetails.delta.dx;
    });
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  double randomNumber(){
    var r=new Random ();
    int num=r.nextInt(101);
    return(50+num)/100;
  }

  void safeSetState(Function function) {
    if (mounted && animationController.isAnimating) {
      setState(() {function();
      });
    }
  }

}
