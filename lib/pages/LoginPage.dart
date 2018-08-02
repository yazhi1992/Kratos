import 'package:flutter/material.dart';
import 'package:Kratos/utils/XYRoute.dart';
import 'package:Kratos/widget/BaseApp.dart';
import 'package:Kratos/widget/ProgressButton.dart';

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
    setState(() {
      autoFocus = false;
    });
    var name = _nameInputController.text;
    var pwd = _pwdInputController.text;
    print("$name-$pwd");
    XYRoute.gotoProjectListPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
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
