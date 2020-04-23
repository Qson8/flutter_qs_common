import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:qs_common/qs_common/base/base.dart';
import 'package:qs_common/qs_common/base/config.dart';
import '../api.dart';

/// @author Qson
/// @create 2019/12/12
/// @Describe Log 拦截器
class LogsInterceptors extends MyInterceptorsWrapper {
  static const String TAG = "";
  
  Map<String,Map<String,dynamic>> logs = {};

  LogsInterceptors();

  @override
  onRequest(RequestOptions options) async {
    try {
      if (Config.DEBUG) {
              Map<String,dynamic> map = Map<String,dynamic>();
              map["请求"] = options.method;
              map["url"] = options.path;
              map["header"] = options.headers;
              map["data"] = options.data;
              map["querymaps"] = options.queryParameters;
              logs[options.path] = map;
          }
    } catch (e,s) {
      log.i2(e,s);
    }
    
    return options;
  }

  @override
  onResponse(Response response) async {
    try {
      if (Config.DEBUG) {
            Map map = (logs.remove(response?.request?.path ?? ""))??{};
            map["response"] = response??"";
            log.dMap(map);
          }
    } catch (e,s) {
      log.i2(e,s);
    }
    return response; // continue
  }

  @override
  onError(DioError err) async {
    try {


      if (Config.DEBUG) {
            Map map = logs.remove(err?.request?.path);
            //Log.d3(map,err,err?.request?.path);
            if(map == null || map.isEmpty){
              map = Map<String,dynamic>();
              map["请求"] = err?.request?.method;
              map["url"] = err?.request?.path;
              map["header"] = err?.request?.headers;
              map["data"] = err?.request?.data;
            }
            map["error"] = err;
            //map["no"] = err.error;
            map["errorResponse"] = err?.response?.toString() ?? "";

            try {
              map["utfReponse"] = JsonDecoder().convert(err?.response?.toString() ??"");
            } catch (e,s) {
              //Log.i2(e,s);
            }
            //
            log.dMap(map);

      }
    } catch (e,s) {
      log.i2(e,s);
    }
    return err; // continue;
  }

  
}
