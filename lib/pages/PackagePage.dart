import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BaseApp.dart';
import 'package:flutter_app/widget/RadiusBorderButton.dart';

class PackagePage extends StatelessWidget {

  final String jenkinsUrl;

  PackagePage({Key key, @required this.jenkinsUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseApp(title: "自动打包", body: _PackagePageView());
  }
}

class _PackagePageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PackagePageViewState();
  }
}

class _PackagePageViewState extends State<_PackagePageView> {

  _buildButton(String text, var onTap) {
    return RadiusBorderButton(
        text: text,
        width: 300.0,
        height: 50.0,
        radius: 25.0,
        margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
        backgroundColor: Colors.white,
        textColor: Theme
            .of(context)
            .accentColor,
        boardWidth: 1.0,
        boardColor: Theme
            .of(context)
            .accentColor,
        textSize: 20.0,
        onTap: onTap
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: _buildButton("渠道包", () {

            }),
          ),
          _buildButton("测试包", () {

          }),
          _buildButton("正式包", () {

          }),
        ],
      ),
    );
  }
}