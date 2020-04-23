
import 'package:dio/dio.dart';
import 'package:qs_common/qs_common/base/base.dart';
import '../api.dart';


/// @author yangbang
/// @create 2019/12/12
/// @Describe head拦截器
class HeaderInterceptors extends MyInterceptorsWrapper {
  HeaderInterceptors();

  @override
  onRequest(RequestOptions options) async {
    ///超时
    options.connectTimeout = 30000;
    options.headers.addAll({"SBID":device.identifier});

    return options;
  }

}
