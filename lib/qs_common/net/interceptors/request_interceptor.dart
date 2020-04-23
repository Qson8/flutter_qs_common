
import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:qs_common/qs_common/base/base.dart';
import 'package:qs_common/qs_common/base/config.dart';
import 'package:qs_common/qs_common/date/date.dart';
import 'package:crypto/crypto.dart';
import 'package:qs_common/qs_common/random/random.dart';
import '../../common.dart';
import '../api.dart';
import '../code.dart';
import '../result_data.dart';

/// @author Qson
/// @create 2019/12/12
/// @Describe reponse 拦截器
/// 签名算法：
/// 签名生成的通用步骤如下：
/// 第一步，设所有发送或者接收到的数据为集合M，将集合M内非空参数值的参数按照参数名ASCII码从小到大排序（字典序），使用URL键值对的格式（即key1=value1&key2=value2…）拼接成字符串。
/// 第二步，拼接成的字符串，拼接上key（app授权时生成的key）得到stringSignTemp字符串，并对stringSignTemp进行MD5运算，转为大写字母，得到值即为sign。
/// 接口必传参数：
/// sign	string	详见签名算法nonce_str	string	随机字符串，长度要求在32位以内timestamp	string	10位时间戳
class RequestInterceptors extends MyInterceptorsWrapper {

  static const TAG = "RequestInterceptors";
  static String TOKEN = "";
  RequestInterceptors();
  @override
  onRequest(RequestOptions options) async {
    //授权码

    String method = options.method;
    if(method==Constant.GET){

      SplayTreeMap<String,dynamic> sortMap = SplayTreeMap();
      Map<String,dynamic> map = Map<String, dynamic>.from(options.data??Map());
      map.forEach((String key,value){
        if(value!=null&&value is String){
          String temp = value as String;
          temp.trim();
        }
      });

      //Log.dTAG(TAG,"begin map=$map");

      StringBuffer stringBuffer = StringBuffer();
      if(!map.containsKey("token")){
        map["token"] = TOKEN;
      }
      map["timestamp"] = DateUtil.getNowDateSs();
      map["nonce_str"] = RandomUtil.randomString(32);

      sortMap.addAll(map);
      sortMap.forEach((key,value){
        if(value is List){
          value = jsonEncode(value);
        }else if(value is Map){
          value = jsonEncode(value);
        }
        stringBuffer.write("$key=$value&");
      });
      String apiKey  = await Storage.get(Config.API_KEY);
      if (apiKey == null || apiKey.isEmpty) {
        return dio.resolve(new ResultData(
            Code.errorHandleFunction(Code.NO_AUTH, "key not auth", false),
            false, Code.NO_AUTH));
      } else {
        stringBuffer.write("key=$apiKey");
        sortMap["key"] = apiKey;
      }
      //Log.dTAG(TAG,stringBuffer.toString());
      map["sign"] = md5.convert(utf8.encode(stringBuffer.toString())).toString().toUpperCase();

      options.queryParameters = map; //FormData.fromMap(map);
      options.data = null;
    }else if(method==Constant.POST||method==Constant.PUT||method==Constant.DELETE){

      try {

        SplayTreeMap<String,dynamic> sortMap = SplayTreeMap();
        Map<String,dynamic> map = Map<String, dynamic>.from(options.data??Map());
        map.forEach((String key,value){
          if(value!=null&&value is String){
            String temp = value as String;
            temp.trim();
          }
        });
        //Log.dTAG(TAG,"begin map=$map");

        StringBuffer stringBuffer = StringBuffer();

        map["timestamp"] = DateUtil.getNowDateSs();
        map["nonce_str"] = RandomUtil.randomString(32);
        if(!map.containsKey("token")){
          map["token"] = TOKEN;
        }

        sortMap.addAll(map);
        sortMap.forEach((key,value){
          if(value is List){
            value = jsonEncode(value);
          }else if(value is Map){
            value = jsonEncode(value);
          }
          stringBuffer.write("$key=$value&");
        });


        String apiKey  = await Storage.get(Config.API_KEY);
        if (apiKey == null || apiKey.isEmpty) {
          return dio.resolve(new ResultData(
              Code.errorHandleFunction(Code.NO_AUTH, "key not auth", false),
              false, Code.NO_AUTH));
        } else {
          stringBuffer.write("key=$apiKey");
          sortMap["key"] = apiKey;
        }

        //Log.dTAG(TAG,stringBuffer.toString());
        //print(stringBuffer.toString());
        map["sign"] = md5.convert(utf8.encode(stringBuffer.toString())).toString().toUpperCase();

        options.data = jsonEncode(map); //FormData.fromMap(map);
        //options.data = FormData.fromMap(map)
        //options.queryParameters = null;

      } catch (e,s) {
        log.i2(e,s);
      }
    }
    //options.headers["Authorization"] = _token;
    return options;
  }

}
