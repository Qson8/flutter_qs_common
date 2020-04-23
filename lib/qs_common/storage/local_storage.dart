import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// @author Qson
/// @create 2019/12/12
/// @Describe 本地存储 (依赖 shared_preferences)
/// 
class Storage {
  static save(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      prefs.setString(key, value);
    } else {
      prefs.setBool(key, value);
    }
  }

  static get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static getMap(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = prefs.getString(key);
    if (temp == null || temp.isEmpty) {
      return {};
    } else {
      return json.decode(temp);
    }
  }

  static saveMap(String key, Map map) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(key, (jsonEncode(map)).toString());
  }

  static saveBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<List<String>> getList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  static saveList(String key, List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, list);
  }

  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
