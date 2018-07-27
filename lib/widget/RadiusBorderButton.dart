import 'package:flutter/material.dart';

//带圆角的按钮
class RadiusBorderButton extends StatelessWidget {

  var backgroundColor;
  var boardWidth;
  var boardColor;
  var radius;
  var textColor;
  var textSize;
  var text;
  var onTap;
  var margin;
  var width;
  var height;

  RadiusBorderButton({this.backgroundColor = Colors.white
    , this.boardWidth = 0.0
    , this.boardColor = Colors.transparent
    , this.radius = 0.0
    , this.textColor = Colors.black
    , this.textSize = 14.0
    , @required this.text
    , this.onTap
    , this.margin
    , this.width
    , this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          border: Border.all(width: boardWidth, color: boardColor)
      ),
      child: InkWell(
        child: Center(
          child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor, fontSize: textSize)
          ),
        ),
        onTap: onTap,
      ),
    );
  }

}