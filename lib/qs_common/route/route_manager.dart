import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// @author Qson
/// @create 2019/12/26
/// @Describe
class RouteManager {
  static void pop(context, {arguments}) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop(arguments);
    }
  }

  static Future pushNamed(context, name, {arguments}) {
    return Navigator.pushNamed(context, name,
        arguments: arguments == null ? arguments : Map.from(arguments));
  }

  static void pushNamedNotCopy(context, name, {arguments}) {
    Navigator.pushNamed(context, name,
        arguments: arguments == null ? arguments : arguments);
  }

  static void popAndpushName(context, name, {arguments}) {
    Navigator.popAndPushNamed(context, name,
        arguments: arguments == null ? arguments : Map.from(arguments));
  }

  static void pushWidget(context, widget) {
    Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
      return widget;
    }));
  }

  static Future pushAndRemoveWidget(context, widget, {setting}) async {
    return await Navigator.pushAndRemoveUntil(
        context,
        new CupertinoPageRoute(
            settings: setting,
            builder: (ctx) {
              return widget;
            }),
        (router) => router == null);
  }

  static void pushReplacement(context, widget, {settings}) {
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (ctx) {
              return widget;
            },
            settings: settings));
  }

  /*static void popUntil(context,widget){
    //Navigator.of(context).popUntil();
    Navigator.of(context).popUntil(new CupertinoPageRoute(builder: (ctx) {
      return widget;
    }),(router) => router == null);
  }
*/

  static void popApp(context, {arguments}) {
    if (Navigator.canPop(context)) {
      RouteManager.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }
}

class FadeRoute extends PageRouteBuilder {
  final builder;
  FadeRoute({this.builder})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return builder(context);
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

///页面路由跳转管理
class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _sendScreenView(PageRoute<dynamic> route, bool isPush) {
    String screenName = route?.settings?.name ?? "";
    /*
    if (screenName != null && screenName == MainTab.NAME) {
      if (isPush) {
        isMainTabActive = false;
        //svPageChangeEventBus.fire('pause');
      } else {
        isMainTabActive = true;
      }
    }
    */
    //log.d('screenName $screenName',isPush);
    // do something with it, ie. send it to your analytics service collector
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    print('didPush route $route preRoute $previousRoute');
    if (route is PageRoute) {
      _sendScreenView(previousRoute, true);
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    /*print('didReplace $newRoute');
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute,false);
    }*/
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    print('didPop preRoute $previousRoute route $route');
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute, false);
    }
  }
}
