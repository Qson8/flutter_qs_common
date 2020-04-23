

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

import '../api.dart';
import '../code.dart';
import '../result_data.dart';

///是否需要弹提示
const NOT_TIP_KEY = "noTip";

/// @author yangbang
/// @create 2019/12/12
/// @Describe 错误拦截
class ErrorInterceptors extends MyInterceptorsWrapper {

  ErrorInterceptors() : super();

  @override
  onRequest(RequestOptions options) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return dio.resolve(new ResultData(
          Code.errorHandleFunction(Code.NETWORK_ERROR, "网络异常", false),
          false,
          Code.NETWORK_ERROR));
    }
    return options;
  }
}
