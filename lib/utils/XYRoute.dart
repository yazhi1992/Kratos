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

  static _navigate(BuildContext context, Widget widget) {
//    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return widget;
        },
        transitionsBuilder: (_, animation, secondaryAnimation, Widget child) {
//          return SlideTransition(
//            position: new Tween<Offset>(
//              begin: const Offset(1.0, 0.0),
//              end: Offset.zero,
//            ).animate(animation),
//            child: child,
//          );

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

          return new FadeTransition(
            opacity: animation,
            child: new FadeTransition(
              opacity:
              new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: child,
            ),
          );
        }
    ));
  }
}