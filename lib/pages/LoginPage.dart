import 'package:Kratos/utils/DownloadUtil.dart';
import 'package:flutter/material.dart';
import 'package:Kratos/utils/XYRoute.dart';
import 'package:Kratos/widget/BaseApp.dart';
import 'package:Kratos/widget/ProgressButton.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseApp(title: "登录", body: _LoginView(), isRoot: true);
  }
}

class _LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginViewState();
  }

}

class _LoginViewState extends State<_LoginView> {

  var _nameInputController = new TextEditingController();
  var _pwdInputController = new TextEditingController();
  var autoFocus = false;

  void _login() {
//    setState(() {
//      autoFocus = false;
//    });
//    var name = _nameInputController.text;
//    var pwd = _pwdInputController.text;
//    print("$name-$pwd");
//    XYRoute.gotoProjectListPage(context);

    //复制到剪贴板
//    Clipboard.setData(ClipboardData(text: "from flutter"));

    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("haha"), backgroundColor: Colors.blue,));
  }

  double downloadProgress = 0.0;
  String btnText = "下载";
  bool isDownloading = false;

  _updateText() {
    setState(() {
      isDownloading = !isDownloading;
      if (isDownloading) {
        btnText = "暂停";
        var url = "https://flutter.io/images/flutter-mark-square-100.png";
        DownloadUtil.download(url, (received, total) {
          _updateProgress(received, total);
        });
      } else {
        btnText = "下载";
      }
    });
  }

  _updateProgress(int received, int total) {
    setState(() {
//      downloadProgress = (received / total * 100).toStringAsFixed(0);
      //保留一位小数
      downloadProgress = (received / total);
      print("$received -- $total");
//      print((received / total * 100).toStringAsFixed(0) + "%");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ProgressButton(
              width: 50.0,
              height: 25.0,
              text: btnText,
              progress: downloadProgress,
              onTap: () {
                _updateText();
              },
            ),
          ),
          //Column 子组件默认居中
          Container(
            padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 50.0),
            child: Image.asset(
                "assets/images/ic_launcher.png"
                , width: 80.0, height: 80.0),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 20.0),
            child: TextField(
              autofocus: autoFocus,
              controller: _nameInputController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "请输入账户"),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 20.0),
            child: TextField(
              controller: _pwdInputController,
              obscureText: true,
              decoration: InputDecoration(labelText: "请输入密码"),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 20.0),
            width: 500.0,
            child: RaisedButton(
                child: Text("登录",
                    style: TextStyle(color: Colors.white)),
                color: Theme
                    .of(context)
                    .accentColor,
                onPressed: () {
                  _login();
                }),
          )
        ],
      ),
    );
  }

}
