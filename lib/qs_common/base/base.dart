library base;

import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qs_common/qs_common/log/log.dart';
import 'package:qs_common/qs_common/net/address.dart';
import 'package:qs_common/qs_common/net/api.dart';
import 'package:qs_common/qs_common/style/style.dart';
import '../net/net.dart';
import '../base/base.dart' as QSBase;
import '../net/interceptors/token_interceptor.dart' as Token;
import 'config.dart';
import 'device_info.dart';

export './text.dart';
export './config.dart';
export './regex.dart';
export './email_validator.dart';
export './device_info.dart';
export './config.dart';

/// @author Qson
/// @create 2020/1/15
/// @Describe

final HttpManager httpManager = HttpManager([
  DioCacheManager(CacheConfig(baseUrl: Address.host)).interceptor,
  ErrorInterceptors(),
  HeaderInterceptors(),
  Token.TokenInterceptors(),
  RequestInterceptors(),
  LogsInterceptors(),
  ResponseInterceptors(),
]);
final Log log = Log(Config.DEBUG);
final DeviceInfo device = DeviceInfo();
final QSColors color = QSColors();
QSSise size;
QSTextStyle textStyle;

initStyle(QSSise s) {
  size = s;
  textStyle = QSTextStyle(s, color);
  QSBase.textStyle = textStyle;
  QSBase.size = s;
}

initDevice() {
  device.getDeviceInfo();
}

final Toasts Toast = Toasts();

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

abstract class Base {
  /*//路由名称
  get NAME;*/
  //跳转参数
  Map args = {};
  get SH => size.SH;
  get SW => size.SW;
  get padding => size.padding;
  get small_padding => size.small_padding;
  get backMargin => size.backMargin;
  get appBarHeight => size.appBarHeight;
  get biglarerTextSiez => size.biglarerTextSiez;
  get lagerTextSize => size.lagerTextSize;
  get bigTextSize => size.bigTextSize;
  get middleTextWhiteSize => size.middleTextWhiteSize;
  get normalTextSize => size.normalTextSize;
  get smallTextSize => size.smallTextSize;
  get minTextSize => size.minTextSize;

  get TAG;
}

class Toasts {
  show(String string) {
    Fluttertoast.showToast(msg: string);
  }
}
