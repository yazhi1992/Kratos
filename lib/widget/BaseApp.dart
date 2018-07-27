import 'dart:async';
import 'package:flutter/material.dart';

class BaseApp extends StatelessWidget {

  final String title;
  final Widget body;
  final bool isRoot; //根页面

  BaseApp(
      {@required String this.title, @required Widget this.body, this.isRoot = false});

  @override
  Widget build(BuildContext context) {
    Widget _leadingIcon() {
      if (isRoot) {
        return null;
      } else {
        return IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            });
      }
    }

    _showDialog() {
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return new AlertDialog(
//              title: new Text('提示'),
              content: new Text('确认退出？'),
              actions: <Widget>[
                new FlatButton(
                  child: new Text(
                    '取消',
                    style: new TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text(
                    '确定',
                    style: new TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
//                    Navigator.of(context, rootNavigator: true).pop(this);
                  },
                )
              ],
            );
          });
    }

    Widget _buildHome() {
      if (isRoot) {
        return MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                  title: Text(title),
                  leading: _leadingIcon()
              ),
              body: body
          ),
        );
      } else {
        return Scaffold(
            appBar: AppBar(
                title: Text(title),
                leading: _leadingIcon()
            ),
            body: body
        );
      }
    }

    Future<bool> _onWillPop() {
      if (isRoot) {
        _showDialog();
      } else {
        Navigator.pop(context);
      }
      return new Future.value(false);
    }

    return Scaffold(
        appBar: AppBar(
            title: Text(title),
            leading: _leadingIcon()
        ),
        body: body
    );
//    return WillPopScope(
//        child: _buildHome(),
//        onWillPop: _onWillPop
//    );
  }

}
