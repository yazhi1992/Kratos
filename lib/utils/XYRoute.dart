import 'package:Kratos/pages/DutyHelperPage.dart';
import 'package:Kratos/pages/LogDetailPage.dart';
import 'package:Kratos/pages/LogListPage.dart';
import 'package:Kratos/pages/MySqlLoginPage.dart';
import 'package:flutter/material.dart';
import 'package:Kratos/pages/ProjectDetail.dart';
import 'package:Kratos/pages/ProjectListPage.dart';
import 'package:Kratos/pages/PackagePage.dart';

class XYRoute {

  static gotoProjectListPage(BuildContext context) {
    _navigate(context, ProjectListPage());
  }

  static gotoPackage(BuildContext context, String jenkinsUrl) {
    _navigate(context, PackagePage(jenkinsUrl: jenkinsUrl));
  }

  static gotoProjectDetailPage(BuildContext context, String name) {
    _navigate(context, ProjectDetail(title: name));
  }

  static gotoLogListPage(BuildContext context, String phone, bool isStu) {
    _navigate(context, LogListPage(phone: phone, isStu: isStu));
  }

  static gotoLogDetailPage(BuildContext context, List<String> data) {
    _navigate(context, LogDetailPage(showDatas: data));
  }

  static gotoDutyHelperPage(BuildContext context, bool replace) {
    var dutyPage = DutyHelperPage();
    if (replace) {
      _replace(context, dutyPage);
    } else {
      _navigate(context, dutyPage);
    }
  }

  static gotoQueryLog(BuildContext context) {
//    _navigate(context, ProjectDetail(title: name));
  }

  static gotoMySqlLoginPage(BuildContext context) {
    _navigate(context, MySqlLoginPage());
  }

  static _navigate(BuildContext context, Widget widget) {
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return widget;
        },
        transitionsBuilder: _buildRouteTransitionsBuilder()
    ));
  }

  static _replace(BuildContext context, Widget widget) {
    Navigator.of(context).pushReplacement(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return widget;
        },
        transitionsBuilder: _buildRouteTransitionsBuilder()
    ));
  }

  static RouteTransitionsBuilder _buildRouteTransitionsBuilder() {
    return (_, animation, secondaryAnimation, Widget child) {
      return SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: new SlideTransition(
          position: new Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(-0.2, 0.0),
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
    };
  }

}

//          return SlideTransition(
//            position: new Tween<Offset>(
//              begin: const Offset(1.0, 0.0),
//              end: Offset.zero,
//            ).animate(animation),
//            child: child,
//          );

//return new FadeTransition(
//opacity: animation,
//child: new FadeTransition(
//opacity:
//new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
//child: child,
//),
//);