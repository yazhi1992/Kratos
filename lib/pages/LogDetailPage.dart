import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Kratos/widget/BaseApp.dart';

class LogDetailPage extends StatelessWidget {

  List<String> showDatas;

  LogDetailPage({@required this.showDatas});

  @override
  Widget build(BuildContext context) {
    return BaseApp(
      title: "日志详情",
      body: LogDetailView(showDatas: showDatas),
    );
  }
}

class LogDetailView extends StatefulWidget {

  List<String> showDatas;

  LogDetailView({@required this.showDatas});

  @override
  State<StatefulWidget> createState() {
    return LogDetailViewState(showDatas: showDatas);
  }
}

class LogDetailViewState extends State<LogDetailView> {

  List<String> showDatas;

  LogDetailViewState({@required this.showDatas});

  _buildItem(String text) {
    return InkWell(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Align(child: Text(text,
              style: TextStyle(fontSize: 18.0)),
              alignment: Alignment.centerLeft)
      ),
      onTap: () {

      }
      ,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: showDatas.length * 2,
      itemBuilder: (context, index) {
        if (index.isOdd) {
          return Divider();
        } else {
          index = index ~/ 2;
          if (index == 0) {
            return Container(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: _buildItem(showDatas[index]),
            );
          }
          return _buildItem(showDatas[index]);
        }
      },);
  }
}
