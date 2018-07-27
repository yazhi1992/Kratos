import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_app/pages/ProjectDetail.dart';
import 'package:flutter_app/utils/XYRoute.dart';
import 'package:flutter_app/widget/BaseApp.dart';

class ProjectListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseApp(title: "项目列表", body: _ProjectPageView());
  }
}

class _ProjectPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectPageViewState();
  }
}

class _ProjectPageViewState extends State<_ProjectPageView> {

  var projectDatas;

  _getProjectList() async {
    setState(() {
      projectDatas = ["haha", "gogo", "gogo", "gogo"];
    });
  }

  @override
  void initState() {
    super.initState();
    _getProjectList();
  }

  _buildItem(String name) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
            child: Image.network(
              "https://upload.jianshu.io/users/upload_avatars/1929170/2c01ba904fa9.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240"
              , width: 70.0, height: 70.0,),
          ),
          Text(name,
            style: TextStyle(fontSize: 20.0),
          )
        ],
      ),
      onTap: () {
        _gotoProjectDetail(name);
      },
    );
  }

  _gotoProjectDetail(String title) {
    XYRoute.gotoProjectDetailPage(context, title);
  }

  @override
  Widget build(BuildContext context) {
    if (projectDatas == null) {
      return Center(
          child: CircularProgressIndicator()
      );
    } else {
      return ListView.builder(
        itemCount: projectDatas.length * 2,
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider();
          } else {
            index = index ~/ 2;
            if (index == 0) {
              return Container(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: _buildItem(projectDatas[index]),
              );
            }
            return _buildItem(projectDatas[index]);
          }
        },);
    }
  }

}


