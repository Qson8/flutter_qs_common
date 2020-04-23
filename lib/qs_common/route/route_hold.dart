import 'package:flutter/material.dart';
import 'package:qs_common/qs_common/base/config.dart';
import 'package:qs_common/qs_common/route/route_manager.dart';
import '../common.dart';

/// 路由拦截
/// 可处理登录页的拦截
class RouteHold extends RouteManager {
  // 页面调转拦截
  static void pushLoginHold(BuildContext context,
      {Function action, bool isPush = true}) async {
    bool isLogin = await Storage.getBool(Constant.IS_LOGIN);
    if (!isLogin) {
      if (isPush) {
        // RouteManager.pushWidget(
        //   context,
          // ProviderConfig.getInstance().getLoginPage(isFirst: false),
        // );
      } else {
        // RouteManager.pushReplacement(
        //   context,
        //   ProviderConfig.getInstance().getLoginPage(isFirst: false),
        // );
      }
    } else {
      if (action != null) action();
    }
  }
}
