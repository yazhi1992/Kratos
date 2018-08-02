import 'package:flutter/material.dart';

class ProgressButton extends StatelessWidget {

  var backgroundColor;
  var textColor;
  var width;
  var height;
  var fontSize;
  var text;
  var progress;

  ProgressButton(
      {@required this.backgroundColor, @required this.textColor, @required this.width, @required this.height,
        this.fontSize = 15.0,
        @required this.progress,
        @required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            child: Center(
              child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: fontSize, color: textColor)),),
          ),
          Stack(
              children: <Widget>[
                ClipRect(
                  clipper: _RatingBarClipper(width: width * progress),
                  child: Container(width: width,
                      height: height,
                      child: CustomPaint(
                          painter: MyPainter(
                            textColor,
                            backgroundColor,
                            text,
                            progress,
                            fontSize,
                          ),
                          size: Size(width, height)
                      )),
                )
              ]),
        ]
    );
  }

}

class _RatingBarClipper extends CustomClipper<Rect> {
  final double width;

  _RatingBarClipper({this.width}) : assert(width != null);

  @override
  Rect getClip(Size size) {
    return new Rect.fromLTRB(0.0, 0.0, width, size.height);
  }

  @override
  bool shouldReclip(_RatingBarClipper oldClipper) {
    return width != oldClipper.width;
  }
}

class MyPainter extends CustomPainter {

  var backgroundColor;
  var textColor;
  var text;
  var progress;
  var textSize;

  MyPainter(this.backgroundColor, this.textColor, this.text, this.progress,
      this.textSize);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    Rect rect = Rect.fromLTRB(
        0.0, 0.0, size.width, size.height);
    canvas.drawRect(rect, paint);
    TextSpan sp = TextSpan(
        style: TextStyle(fontSize: textSize, color: textColor), text: text);
    TextPainter tp = TextPainter(text: sp,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas,
        Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2));
    Rect clipRect = Rect.fromLTRB(
        20.0, 20.0, 50.0, 50.0);
//    canvas.clipRect(clipRect, clipOp: ClipOp.difference);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}