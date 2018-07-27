import 'package:flutter/material.dart';
import 'package:flutter_app/utils/XYRoute.dart';
import 'package:flutter_app/widget/BaseApp.dart';
import 'package:flutter_app/widget/RadiusBorderButton.dart';

class ProjectDetail extends StatelessWidget {

  final String title;

  ProjectDetail({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseApp(title: title, body: _ProjectDetailView());
  }

}

class _ProjectDetailView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectDetailViewState();
  }
}

class _ProjectDetailViewState extends State<_ProjectDetailView> {

  var projectHistoryDatas;

  _getProjectList() async {
    setState(() {
      projectHistoryDatas = ["haha", "gogo", "gogo", "gogo"];
    });
  }

  @override
  void initState() {
    super.initState();
    _getProjectList();
  }

  _buildItem(String name) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(40.0, 0.0, 20.0, 0.0),
          child: Image.network(
            "https://upload.jianshu.io/users/upload_avatars/1929170/2c01ba904fa9.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240"
            , width: 70.0, height: 70.0,),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("2018999",
                    style: TextStyle(fontSize: 20.0),
                  )
              ),
              Container(
                height: 10.0,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("2018",
                    style: TextStyle(fontSize: 20.0),
                  )
              )
            ],
          ),
        ),
        Column(
          children: <Widget>[
            RadiusBorderButton(
              text: "安装",
              width: 60.0,
              height: 30.0,
              margin: const EdgeInsets.fromLTRB(0.0, 00.0, 30.0, 0.0),
              textColor: Theme
                  .of(context)
                  .accentColor,
              radius: 15.0,
              boardWidth: 1.0,
              boardColor: Theme
                  .of(context)
                  .accentColor,
            ),
            RadiusBorderButton(
              text: "分享",
              width: 60.0,
              height: 30.0,
              margin: const EdgeInsets.fromLTRB(0.0, 10.0, 30.0, 0.0),
              textColor: Colors.red,
              radius: 15.0,
              boardWidth: 1.0,
              boardColor: Colors.red,
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (projectHistoryDatas == null) {
      return Center(
          child: CircularProgressIndicator()
      );
    } else {
      return Column(
        children: <Widget>[
          RadiusBorderButton(
            text: "一键打包",
            width: 200.0,
            height: 50.0,
            margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
            textColor: Colors.white,
            textSize: 20.0,
            radius: 25.0,
            backgroundColor: Theme.of(context).accentColor,
            onTap: (){
              XYRoute.gotoPackage(context, "123");
            },
          ),
          Expanded(
            child: ListView.builder(
                itemCount: projectHistoryDatas.length * 2,
                itemBuilder: (context, index) {
                  if (index.isOdd) {
                    return Divider();
                  } else {
                    index = index ~/ 2;
                    if (index == 0) {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        child: _buildItem(projectHistoryDatas[index]),
                      );
                    }
                    return _buildItem(projectHistoryDatas[index]);
                  }
                }
            ),
          )
        ],
      );
    }
  }


}