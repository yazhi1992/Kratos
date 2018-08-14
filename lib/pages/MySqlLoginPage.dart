import 'dart:async';

import 'package:Kratos/utils/SqlConnectHelper.dart';
import 'package:Kratos/utils/Utils.dart';
import 'package:Kratos/widget/LoadingView.dart';
import 'package:flutter/material.dart';
import 'package:Kratos/utils/XYRoute.dart';
import 'package:Kratos/widget/BaseApp.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySqlLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseApp(title: "小助手登录", body: _MySqlLoginView());
  }
}

class _MySqlLoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MySqlLoginViewState();
  }
}

class _MySqlLoginViewState extends State<_MySqlLoginView> {

  var _nameInputController = new TextEditingController();
  var _pwdInputController = new TextEditingController();
  var _hostInputController = new TextEditingController();

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      _updateInfo(prefs.getString('host') ?? "", prefs.getString('name') ?? "",
          prefs.getString('pwd') ?? "");
    });
  }

  _updateInfo(String host, String name, String pwd) async {
    setState(() {
      _hostInputController.text = host;
      _nameInputController.text = name;
      _pwdInputController.text = pwd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //Column 子组件默认居中
              Container(
                padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 50.0),
                child: Image.asset(
                    "assets/images/ic_launcher.png"
                    , width: 80.0, height: 80.0),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 20.0),
                child: TextField(
                  controller: _hostInputController,
                  decoration: InputDecoration(labelText: "请输入地址"),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 20.0),
                child: TextField(
                  controller: _nameInputController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "请输入账号"),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 20.0),
                child: TextField(
                  controller: _pwdInputController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "请输入密码"),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 60.0),
                width: 500.0,
                child: RaisedButton(
                    child: Text("连接",
                        style: TextStyle(color: Colors.white)),
                    color: Theme
                        .of(context)
                        .accentColor,
                    onPressed: () {
                      var name = _nameInputController.text;
                      var pwd = _pwdInputController.text;
                      var host = _hostInputController.text;
                      if (host.isEmpty) {
                        Utils.showSnackBar(context, "地址不能为空");
                        return;
                      }
                      if (name.isEmpty) {
                        Utils.showSnackBar(context, "账户名不能为空");
                        return;
                      }
                      if (pwd.isEmpty) {
                        Utils.showSnackBar(context, "密码不能为空");
                        return;
                      }
                      _updateLoadingView(true);
                      SqlConnectHelper.mysqlLogin(
                          name, pwd, host, (result, msg) {
                        _updateLoadingView(false);
                        if (result) {
                          XYRoute.gotoDutyHelperPage(context, true);
                        } else {
                          Utils.showSnackBar(context, "连接错误，请检查信息是否填写正确");
                        }
                      });
                    }),
              ),
            ],
          ),
        ),
        LoadingView(show: loading)
      ],
    );
  }

  _updateLoadingView(bool show) {
    setState(() {
      loading = show;
    });
  }

}
