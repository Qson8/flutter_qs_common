import 'package:flutter/material.dart';
import '../common.dart';
import 'text_widget.dart';

/// @author Qson
/// @create 2019/12/26
/// @Describe appBar
/// 
class YBAppBar extends AppBar {
  static const double elevations = 0.5;
  YBAppBar({
    leading,
    title,
    actions,
    flexibleSpace,
    bottom,
    double elevation,
    shape,
    backgroundColor,
    brightness,
    iconTheme,
    actionsIconTheme,
    textTheme,
    centerTitle = true,
  }) : super(
          elevation: elevation ?? elevations,
          leading: leading,
          title: title,
          actions: actions,
          flexibleSpace: flexibleSpace,
          bottom: bottom,
          shape: shape,
          backgroundColor: backgroundColor,
          brightness: brightness,
          iconTheme: iconTheme,
          actionsIconTheme: actionsIconTheme,
          textTheme: textTheme,
          centerTitle: centerTitle,
        );

  static withs(context,
      {leading, title, titleWidget, finishWidget, press, elevation}) {
    return YBAppBar(
      elevation: elevation,
      leading: leading ??
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => RouteManager.pop(context),
          ),
      centerTitle: true,
      title: titleWidget ??
          Hero(
              tag: title ?? "",
              child: new Material(
                  color: Colors.transparent,
                  child: new Text(
                    title ?? "",
                    style: textStyle.normalText,
                  ))),
      actions: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: size.backMargin),
          child: new Material(
            color: Colors.transparent,
            child: new GestureDetector(
                onTap: press ??
                    () {
                      Navigator.of(context).pop();
                    },
                child: finishWidget),
          ),
        )
      ],
    );
  }

  static withBack(context, {leading, title, titleWidget, press, elevation}) {
    return YBAppBar(
        elevation: elevation,
        leading: leading ??
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: press ?? () => RouteManager.pop(context),
            ),
        centerTitle: true,
        title: titleWidget ??
            Hero(
                tag: title ?? "",
                child: new Material(
                    color: Colors.transparent,
                    child: new Text(
                      title ?? "",
                      style: textStyle.normalText,
                    ))));
  }

  static withWhite(context, {leading, title, titleWidget, press, elevation}) {
    Color color = Colors.white;
    return YBAppBar(
        elevation: elevation,
        leading: leading ??
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: color,
              ),
              onPressed: press ?? () => RouteManager.pop(context),
            ),
        centerTitle: true,
        title: titleWidget ??
            Hero(
              tag: title ?? "",
              child: new Material(
                color: Colors.transparent,
                child: MiddleWhiteText(title),
              ),
            ));
  }

  static Widget withBackNoTitle(context, {press}) {
    return YBAppBar(
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back),
        onPressed: press ?? () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
    );
  }

  static Widget withFinishNoTitle(context, {finishWidget, press, elevation}) {
    return YBAppBar(
      leading: Text(""),
      elevation: elevation,
      centerTitle: true,
      actions: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: size.backMargin),
          child: new Material(
            color: Colors.transparent,
            child: new GestureDetector(
                onTap: press ??
                    () {
                      RouteManager.pop(context);
                    },
                child: finishWidget),
          ),
        )
      ],
    );
  }

  static Widget withFinish(context, {title, finishWidget, press}) {
    return YBAppBar(
      centerTitle: true,
      title: new Hero(
          tag: title,
          child: new Material(
              color: Colors.transparent,
              child: new Text(
                title,
                style: textStyle.normalText,
              ))),
      actions: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: size.backMargin),
          child: new Material(
            color: Colors.transparent,
            child: new GestureDetector(
                onTap: press ??
                    () {
                      Navigator.of(context).pop();
                    },
                child: finishWidget),
          ),
        )
      ],
    );
  }

  static Widget withCustom(context, Widget widget) {
    return YBAppBar(
      centerTitle: true,
      actions: <Widget>[widget],
    );
  }
}
