import 'package:Kratos/utils/Utils.dart';
import 'package:Kratos/utils/XYRoute.dart';
import 'package:Kratos/widget/BaseApp.dart';
import 'package:Kratos/widget/LoadingView.dart';
import 'package:Kratos/widget/RadiusBorderButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Kratos/utils/SqlConnectHelper.dart';

class DutyHelperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseApp(
      title: "值班小助手",
      body: DutyHelperView(),
    );
  }
}

class DutyHelperView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DutyHelperViewState();
  }
}

class DutyHelperViewState extends State<DutyHelperView> {

  var _phoneInputController = new TextEditingController();
  var verifyCode = "";
  var verifyCodeTime = "";

  String _getInputPhone() {
    var phone = _phoneInputController.text;
    if (phone.isEmpty) {
      Utils.showSnackBar(context, "手机号不能为空");
      return "";
    }
    if (phone.length != 11) {
      Utils.showSnackBar(context, "请输入正确的手机号");
      return "";
    }
    return phone;
  }

  _queryVerifyCode() {
    if (_getInputPhone().isEmpty) return;
    _updateLoadingView(true);
    setState(() {
      SqlConnectHelper.queryVerifyCode(_getInputPhone(), (code, time) {
        _updateLoadingView(false);
        _showCodeAndTime(code, time);
      });
    });
  }

  _gotoLogList() {
    if (_getInputPhone().isEmpty) return;
    XYRoute.gotoLogListPage(context, _getInputPhone(), selected == 0);
  }

  _showCodeAndTime(String code, String time) {
    setState(() {
      verifyCode = code;
      verifyCodeTime = time;
    });
  }

  var selected = 0; //0 学生，1 老师

  _onChangeRole(int value) {
    setState(() {
      selected = value;
    });
  }

  bool loading = false;

  _updateLoadingView(bool show) {
    setState(() {
      loading = show;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
                padding: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 0.0),
                child: TextField(
                  maxLength: 11,
                  controller: _phoneInputController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(labelText: "输入手机号"),
                )
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 0.0),
              height: 35.0,
              child: Align(
                child: Text(
                  "验证码：$verifyCode", style: TextStyle(fontSize: 17.0),),
                alignment: Alignment.centerLeft,),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
              height: 35.0,
              child: Align(
                child: Text(
                  "生成时间：$verifyCodeTime", style: TextStyle(fontSize: 17.0),),
                alignment: Alignment.centerLeft,),
            ),
            RadiusBorderButton(
                text: "查询短信验证码",
                width: 300.0,
                height: 50.0,
                radius: 25.0,
                margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                backgroundColor: Colors.white,
                textColor: Theme
                    .of(context)
                    .accentColor,
                boardWidth: 1.0,
                boardColor: Theme
                    .of(context)
                    .accentColor,
                textSize: 20.0,
                onTap: () {
                  _queryVerifyCode();
                }
            ),
            Row(children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 00.0),
                width: 130.0,
                child: RadioListTile(title: Text("学生"),
                    value: 0, groupValue: selected,
                    onChanged: (value) => _onChangeRole(value)),
              ),
              Container(
                width: 130.0,
                child: RadioListTile(title: Text("老师"),
                    value: 1, groupValue: selected,
                    onChanged: (value) => _onChangeRole(value)),
              ),
            ],),
            RadiusBorderButton(
                text: "查看日志",
                width: 300.0,
                height: 50.0,
                radius: 25.0,
                margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
                backgroundColor: Colors.white,
                textColor: Theme
                    .of(context)
                    .accentColor,
                boardWidth: 1.0,
                boardColor: Theme
                    .of(context)
                    .accentColor,
                textSize: 20.0,
                onTap: () {
                  _gotoLogList();
                }
            )
          ])
      ),
      LoadingView(show: loading)
    ]);
  }

}
