import 'dart:io';
import 'package:device_info/device_info.dart';

/// 设备信息
class DeviceInfo{

  String deviceName;
  String deviceVersion;
  String identifier;
  String param = "";

  DeviceInfo(){
    //print("init device @@@@@@@@@@@@!!!");
    //getDeviceInfo();
  }

  Future<List<String>> getDeviceInfo() async {

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid ) {

      var build = await deviceInfo.androidInfo;
      deviceName = build.model;
      deviceVersion = build.version.toString();
      identifier = build.androidId;  //UUID for Android
      param = "Android";
    } else if(Platform.isIOS ){
      var data = await deviceInfo.iosInfo;
      deviceName = data.name;
      deviceVersion = data.systemVersion;
      identifier = data.identifierForVendor;  //UUID for iOS
      param = "IOS";
    }
    return [deviceName, deviceVersion, identifier];
  }


  String getString() {
    return "$param $deviceName";
  }



  static String deviceId = "";

  static Future<String> getDeviceId() async {
    String identifier;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid ) {
      var build = await deviceInfo.androidInfo;
      identifier = build.androidId;  //UUID for Android
    } else if(Platform.isIOS ){
      var data = await deviceInfo.iosInfo;
      identifier = data.identifierForVendor;  //UUID for iOS
    }
    return identifier;
  }

  static sortMapByKey(Map map){
    List <String> keys = map.keys.toList();
    // key排序
    keys.sort();
  }
}


