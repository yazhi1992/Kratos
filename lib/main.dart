import 'package:flutter/material.dart';
import 'package:Kratos/pages/LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {

  String text = "click";

  changeText() {
    if (text == "click") {
      setState(() {
        text = "Hello";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = new List();
    for (var i = 0; i < 80; i++) {
      var text = new Text("List Item $i", style: TextStyle(fontSize: 30.0, color: const Color(0xff333ccc)),);
      items.add(Padding(padding: const EdgeInsets.all(20.0), child: text));
    }
    return MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text("家有学霸"),
        ),
        body: Center(
          child: InkWell(
//            child: Text(text, style: TextStyle(
//                fontSize: 30.0,
//                color: const Color(0xff333ddd)
//            ),),
//            child: Image.network(
//              "https://upload.jianshu.io/users/upload_avatars/1929170/2c01ba904fa9.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240"
//              , width: 200.0, height: 200.0,),
//            child: new Image.asset(
//              "assets/images/ic_launcher.png"
//              , width: 80.0, height: 80.0),

          child: LoginPage(),

//          child: ListView.builder(itemBuilder: (context, index) {
//            if(index.isOdd) {
//              return Divider(height: 11.0, color: Colors.red);
//            } else {
//              index = index ~/ 2;
//              return items[index];
//            }
//          }),
            onTap: () {
//              changeText();
//              Scaffold.of(context).showSnackBar(
//                  SnackBar(content: new Text("show")));
            },
          ),
        ),
      ),
    );
  }
}
