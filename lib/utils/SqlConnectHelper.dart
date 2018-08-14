import 'package:sqljocky5/sqljocky.dart';
import 'package:date_format/date_format.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SqlConnectHelper {

  static final SqlConnectHelper _singleton = new SqlConnectHelper._internal();

  factory SqlConnectHelper() {
    return _singleton;
  }

  SqlConnectHelper._internal();

  static SqlConnectHelper getInstance() {
    return _singleton;
  }

  var sqlConnection;
  var isConnectingSuc = false;

  static var db = "jiayouxueba_db";

  static mysqlLogin(String username, String password, String host,
      Function connectCallBack) {
    getInstance().sqlConnection = new ConnectionPool(
        host: host,
        port: 3306,
        user: username,
        password: password,
        db: db,
        max: 5);

    getInstance().sqlConnection.query("SELECT 1").then((results) {
      print("connect mysql suc!");
      connectCallBack(true, "connect suc!");
      getInstance().isConnectingSuc = true;
      //sp 存储host、username
      _saveInfoOnDisk(host, username, password);
    }, onError: (e) {
      var msg = "err " + e.toString();
      print(msg);
      connectCallBack(false, msg);
      getInstance().isConnectingSuc = false;
    });
  }

  static _saveInfoOnDisk(String host, String name, String pwd) async {
    final prefs = await SharedPreferences.getInstance();
    // set value
    prefs.setString('host', host);
    prefs.setString('name', name);
    prefs.setString('pwd', pwd);
  }

  static queryVerifyCode(String phone, Function getVerifyCodeCallback) {
    getInstance().sqlConnection.query(
        'SELECT * FROM sms_verify_code WHERE mobile LIKE "%$phone%" ORDER BY gmt_send desc LIMIT 1')
        .then((results) {
      bool noData = true;
      results.forEach((row) {
        noData = false;
        var date = new DateTime.fromMillisecondsSinceEpoch(
            int.parse(row.gmt_send.toString()) * 1000);
        var time = formatDate(date, [yyyy, '/', mm, '/', dd, ' ', HH, ':', nn]);
        getVerifyCodeCallback(row.verify_code.toString(), time);
      });
      if (noData) {
        getVerifyCodeCallback("查无记录", "查无记录");
      }
    }, onError: (e) {
      print("err " + e.toString());
      getVerifyCodeCallback("查无记录", "查无记录");
    });
  }

  static Map<String, String> userIdMap = {};

  static queryUserId(bool isStu, String phone, Function getUserIdCallback) {
    String key = "$phone$isStu";
    if (userIdMap.containsKey(key)) {
      getUserIdCallback(userIdMap[key]);
    } else {
      String table = isStu
          ? "user_parent_basic_info"
          : "user_scholar_basic_info";
      getInstance().sqlConnection.query(
          'SELECT id FROM $table WHERE mobile=$phone')
          .then((results) {
        return results.toList();
      }, onError: (e) {
        print("err " + e.toString());
        getUserIdCallback(null);
      })
      .then((datas) {
        bool noData = true;
        datas.forEach((row) {
          noData = false;
          String userId = row.id.toString();
          userIdMap[key] = userId;
          getUserIdCallback(userId);
        });
        if (noData) {
          getUserIdCallback(null);
        }
      });
    }
  }

  static queryLog(String uploaderId, Function connectCallBack) {
    List<Map<String, String>> logs = List();
    getInstance().sqlConnection.query(
        'SELECT * FROM client_log WHERE uploader=$uploaderId ORDER BY gmt_create desc LIMIT 100')
        .then((results) {
      return results.toList();
    }, onError: (e) {
      print("err " + e.toString());
      connectCallBack(null);
    })
        .then((data) {
      data.forEach((row) {
        print('$row');
        Map<String, String> itemValue = {};
        itemValue["content"] = row.content.toString();
        itemValue["log_type"] = row.log_type.toString();
        itemValue["ua"] = row.ua.toString();
        itemValue["ext"] = row.ext.toString();
        itemValue["gmt_create"] = row.gmt_create.toString();
        itemValue["biz_id"] = row.biz_id.toString();
        itemValue["source"] = row.source.toString();
        logs.add(itemValue);
      });
      connectCallBack(logs);
    });
  }
}