import 'package:dio/dio.dart';
import 'package:qs_common/qs_common/base/base.dart';
import 'package:qs_common/qs_common/base/config.dart';
import 'package:synchronized/synchronized.dart' as synchronized;
import '../../common.dart';
import '../api.dart';

/// @author yangbang
/// @create 2019/12/12
/// @Describe Token拦截器

class TokenInterceptors extends MyInterceptorsWrapper {
  static const String TAG = "TokenInterceptors";

  TokenInterceptors();

  bool _token = false;
  final _lock = synchronized.Lock();
  @override
  onRequest(RequestOptions options) async {
    //授权码
    //Log.dTAG(TAG,"begin author1 token ==$_token" );
    if (_token) {
      //认证通过
      //Log.dTAG(TAG,"begin author autho Success1");
      //print("rsaEncode onRequest");
    } else {
      dio.lock();
      await _lock.synchronized(() async {
        // Only this block can run (once) until done
        var authorSuccess = await getAuthorization();
        //Log.dTAG(TAG, "begin author2 token ==$authorSuccess");
        if (authorSuccess) {
          _token = authorSuccess;
          //initClient(_token);
        }
      });
      dio.unlock();
    }
    //options.headers["Authorization"] = _token;
    return options;
  }

  @override
  onResponse(Response response) async {
    return response;
  }

  @override
  onError(DioError err) async {
    try {
      if (err?.response?.statusCode == 403) {
        log.dTAG(TAG, "DioError auth 异常 $err");
        dio.lock();
        dio.interceptors.responseLock.lock();
        dio.interceptors.errorLock.lock();

        await _lock.synchronized(() async {
          await Storage.save(Config.API_KEY, "");
          await clearAuthorization();
          // Only this block can run (once) until done
          var authorSuccess = await getAuthorization();
          if (authorSuccess) {
            _token = authorSuccess;
            //initClient(_token);
          }
        });
        dio.unlock();
        dio.interceptors.responseLock.unlock();
        dio.interceptors.errorLock.unlock();
        return dio.request(err.request.path, options: err.request);
      }
    } catch (e, s) {
      log.i2(e, s);
    }
    return err; // continue;
  }

  ///清除授权
  clearAuthorization() async {
    _token = false;
  }

  ///获取授权token
  getAuthorization() async {
    String apiKey = await Storage.get(Config.API_KEY);
    log.dTAG(TAG, "getAuthorization apiKey==$apiKey");
  }
}
