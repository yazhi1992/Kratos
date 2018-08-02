import 'dart:io';
import 'package:dio/dio.dart';

class DownloadUtil {

  static var dio = new Dio();

  static download(String url, OnDownloadProgress progress) async {
    dio.onHttpClientCreate = (HttpClient client) {
      client.idleTimeout = new Duration(seconds: 0);
    };

//    var url = "https://flutter.io/images/flutter-mark-square-100.png";
    try {
      Response response = await dio.download(url,
          "./example/flutter.png",
          onProgress: progress
      );
      print(response.statusCode);
    } catch (e) {
      print("------------err " + e);
    }
    print("download succeed!");
  }
}