import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {

  bool show;

  LoadingView({@required this.show});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildView(show),
    );
  }

  _buildView(bool show) {
    if (show) {
      return Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Container();
    }
  }

}