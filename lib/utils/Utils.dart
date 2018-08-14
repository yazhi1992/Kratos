import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {

  static showSnackBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: Colors.blue,));
  }

  //复制到剪贴板
  static copyMsgToClipboard(String msg) {
    Clipboard.setData(ClipboardData(text: msg));
  }

  static const toastChannel = const MethodChannel('toast');

  static showToast(String msg) {
      toastChannel.invokeMethod("makeToast").then((value) {
        print("_requestPermission$value");
      });
  }

//  _selectRole() {
//    showDialog(context: context,
//        builder: (BuildContext ctx) {
//          return new AlertDialog(
//            title: new Text('完善信息'),
//            content: new Text('该用户的身份是？'),
//            actions: <Widget>[
//              new FlatButton(
//                child: new Text(
//                  '取消',
//                  style: new TextStyle(color: Colors.red),
//                ),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//              ),
//              new FlatButton(
//                child: new Text(
//                  '确定',
//                  style: new TextStyle(color: Colors.blue),
//                ),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                  _gotoLogList();
//                },
//              )
//            ],
//          );
//        });
//  }

}