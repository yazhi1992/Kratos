import 'dart:async';
import 'dart:convert';
import 'package:Kratos/utils/SqlConnectHelper.dart';
import 'package:Kratos/utils/Utils.dart';
import 'package:Kratos/utils/XYRoute.dart';
import 'package:Kratos/widget/RadiusBorderButton.dart';
import 'package:flutter/material.dart';
import 'package:Kratos/widget/BaseApp.dart';

class LogListPage extends StatelessWidget {

  String phone;
  bool isStu = true;

  LogListPage({@required this.phone, @required this.isStu});

  @override
  Widget build(BuildContext context) {
    var role = isStu ? "学生" : "老师";
    return BaseApp(
      title: "$role $phone 的日志",
      body: LogListView(phone: phone, isStu: isStu),
    );
  }
}

class LogListView extends StatefulWidget {

  String phone;
  bool isStu = true;

  LogListView({@required this.phone, @required this.isStu});

  @override
  State<StatefulWidget> createState() {
    return LogListViewState(phone: phone, isStu: isStu);
  }
}

class LogListViewState extends State<LogListView> {

  List<Map<dynamic, dynamic>> logs;
  String phone;
  bool isStu = true;

  LogListViewState({@required this.phone, @required this.isStu});

  _emptyList() {
    setState(() {
      logs = [];
    });
  }

  _getProjectList(List<Map<String, String>> logList) {
    setState(() {
      logs = logList;
    });
  }

  @override
  void initState() {
    super.initState();
    SqlConnectHelper.queryUserId(isStu, phone, (userId) {
      if(userId == null) {
        _noUser();
      } else {
        SqlConnectHelper.queryLog(userId, (logList) {
          if(logList.isEmpty) {
            _emptyList();
          } else {
            _getProjectList(logList);
          }
        });
      }
    });
  }

  String _processUA(String str) {
    String os = str;
    try {
      Map valueMap = json.decode(str);
      os = valueMap["os"];
    } catch(e) {
      print("process ua err:${e.toString()}");
    }
    return os;
  }

  _buildItem(Map<String, String> itemData) {
    return InkWell(
      child: Row(children: <Widget>[
        Expanded(flex: 1,
          child: Container(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Column(children: <Widget>[
                Align(
                    child: Text(itemData["content"],
                        maxLines: 1,
                        style: TextStyle(fontSize: 18.0)),
                    alignment: Alignment.centerLeft),
                Align(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 5.0),
                        child: Text(_processUA(itemData["ua"]),
                            maxLines: 1,
                            style: TextStyle(fontSize: 14.0))),
                    alignment: Alignment.centerLeft),
                Align(
                    child: Text(itemData["gmt_create"],
                      style: TextStyle(fontSize: 14.0),),
                    alignment: Alignment.centerLeft),
              ],)
          ),),
        _buildCopyLogEnableIcon(itemData["ext"])
      ],),
      onTap: () {
        List<String> showDatas = new List<String>(itemData.length);
        var index = 0;
        itemData.forEach((key, value) {
          showDatas[index] = "$key\n$value";
          index++;
        });
        XYRoute.gotoLogDetailPage(context, showDatas);
      },
    );
  }

  String _processUrl(String str) {
    String urls = str;
    if(!urls.contains(",")) {
      //单个下载地址
      try {
        List<dynamic> urlList;
        Map valueMap = json.decode(str);
        urlList = valueMap["urls"];
        if(urlList.length == 1) {
          urls = urlList[0];
        }
      } catch(e) {
        print("process ua err:${e.toString()}");
      }
    }
    return urls;
  }

  _buildCopyLogEnableIcon(String logUrl) {
    if (logUrl != null && !logUrl.contains("null")) {
      return Container(
        padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
        child: InkWell(
          child: RadiusBorderButton(
            text: "复制日志\n下载地址",
            textSize: 12.0,
            height: 45.0,
            width: 80.0,
            textColor: Theme
                .of(context)
                .accentColor,
            radius: 5.0,
            boardWidth: 1.0,
            boardColor: Theme
                .of(context)
                .accentColor,
          ),
          onTap: () {
            var newUrl = _processUrl(logUrl);
            Utils.copyMsgToClipboard(newUrl);
            Utils.showSnackBar(context, "已复制日志下载地址到剪贴板");
          },
        ),
      );
    } else {
      return Container();
    }
  }

  bool noUser = false;

  _noUser() {
    setState(() {
      noUser = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(noUser) {
      //查无此用户
      return Center(
        child: Text("未查询到该用户\n请确认信息是否正确"
          , style: TextStyle(fontSize: 16.0)
          , textAlign: TextAlign.center,),
      );
    } else if (logs == null) {
      return Center(
          child: CircularProgressIndicator()
      );
    } else if(logs.isEmpty) {
      //数据为空
      return Center(
        child: Text("该用户未上报过日志"
          , style: TextStyle(fontSize: 16.0)
          , textAlign: TextAlign.center,),
      );
    } else {
      return ListView.builder(
        itemCount: logs.length * 2,
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider();
          } else {
            index = index ~/ 2;
            if (index == 0) {
              return Container(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: _buildItem(logs[index]),
              );
            }
            return _buildItem(logs[index]);
          }
        },);
    }
  }
}
