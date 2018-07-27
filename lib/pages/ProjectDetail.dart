import 'package:flutter/material.dart';

class ProjectDetail extends StatelessWidget {

  final String title;

  ProjectDetail({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text(title)
            ),
            body: ProjectDetailView()
        )
    );
  }

}

class ProjectDetailView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProjectDetailViewState();
  }
}

class ProjectDetailViewState extends State<ProjectDetailView> {

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
        Expanded(child: Container(
          padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
          child: Image.network(
            "https://upload.jianshu.io/users/upload_avatars/1929170/2c01ba904fa9.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240"
            , width: 70.0, height: 70.0,),
        )),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("2018",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.start,
              ),
              Text("2018",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20.0),
              )
            ],
          ),),
        Expanded(child: Column(
          children: <Widget>[
            Container(
              width: 100.0,
              height: 30.0,
              margin: const EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 0.0),
              child: RaisedButton(
                  child: Text("安装",
                      style: TextStyle(color: Colors.white)),
                  color: Theme
                      .of(context)
                      .accentColor,
                  onPressed: () {
                    _package();
                  }),
            ),
            Container(
              width: 100.0,
              height: 30.0,
              margin: const EdgeInsets.fromLTRB(0.0, 10.0, 30.0, 0.0),
              child: RaisedButton(
                  child: Text("分享",
                      style: TextStyle(color: Colors.white)),
                  color: Theme
                      .of(context)
                      .accentColor,
                  onPressed: () {
                    _package();
                  }),
            )
          ],
        ),),
      ],
    );
  }

  _package() {

  }

  @override
  Widget build(BuildContext context) {
    if (projectHistoryDatas == null) {
      return Center(
          child: CircularProgressIndicator()
      );
    } else {
      return ListView.builder(
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
          });
      return Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 20.0),
            width: 500.0,
            child: RaisedButton(
                child: Text("一键打包",
                    style: TextStyle(color: Colors.white)),
                color: Theme
                    .of(context)
                    .accentColor,
                onPressed: () {
                  _package();
                }),
          ),
          ListView.builder(
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
              })
        ],
      );
    }
  }

}