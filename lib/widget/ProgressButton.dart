import 'package:flutter/material.dart';

//仿应用宝下载应用按钮
class ProgressButton extends StatelessWidget {

  var backgroundColor; //进度为0时的背景颜色
  var textColor; //进度为0是的文字颜色
  var width;
  var height;
  var fontSize;
  var text;
  var progress; //0~1 进度值
  var radius;
  var boardWidth;
  var onTap;

  ProgressButton({
    @required this.width,
    @required this.height,
    @required this.progress,
    @required this.text,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.blue,
    this.fontSize = 13.0,
    this.radius = 5.0,
    this.boardWidth = 1.0,
    this.onTap
  }) : assert(progress >= 0 && progress <= 1);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
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
            Container(width: width,
              height: height,
              child: CustomPaint(
                  painter: MyPainter(
                      textColor,
                      backgroundColor,
                      text,
                      progress,
                      fontSize,
                      radius,
                      boardWidth),
                  size: Size(width, height)
              ),
            )
          ]
      ),
      onTap: onTap,
    );
  }
}

class MyPainter extends CustomPainter {

  var backgroundColor;
  var textColor;
  var text;
  var progress;
  var textSize;
  var radius;
  var boardWidth;

  MyPainter(this.backgroundColor, this.textColor, this.text, this.progress,
      this.textSize,
      this.radius,
      this.boardWidth);

  @override
  void paint(Canvas canvas, Size size) {
    //绘制边
    RRect rect = RRect.fromLTRBR(
        0.0, 0.0, size.width, size.height, Radius.circular(radius));
    Paint paint = Paint()
      ..strokeWidth = boardWidth
      ..color = backgroundColor
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(rect, paint);
    //裁剪已下载部分
    Rect clipRect = Rect.fromLTRB(
        0.0, 0.0, size.width * progress, size.height);
    canvas.clipRect(clipRect);
    //绘制已下载部分背景与文字
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(rect, paint);
    //绘制底部文字
    TextSpan sp = TextSpan(
        style: TextStyle(fontSize: textSize, color: textColor), text: text);
    TextPainter tp = TextPainter(text: sp,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas,
        Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}