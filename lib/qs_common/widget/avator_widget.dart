import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qs_common/qs_common/base/base.dart';

/// 头像widget
///

class QSAvator {
  /// 加载网络图
  static imageUrl(String image,
      {String placeholder,
      double width = 55,
      double height = 55,
      double borderWidth = 0.0,
      int certification = 0,
      Color borderColor}) {
    BoxDecoration decoration = borderColor != null
        ? BoxDecoration(
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular((width + borderWidth) * 0.5),
          )
        : null;

    return Container(
      width: width + borderWidth,
      height: height + borderWidth,
      decoration: decoration,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
              alignment: Alignment(0, 1),
              child: ClipOval(
                child: FadeInImage.assetNetwork(
                  width: width + borderWidth,
                  height: height + borderWidth,
                  placeholder: placeholder,
                  image: image,
                  fit: BoxFit.cover,
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.setWidth(16),
              width: size.setWidth(32),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: certification == 0
                        ? [Color(0xFFEEEEEE), Color(0xFFCDCDCD)]
                        : [Color(0xFF8DE396), Color(0xFF3DC445)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 加载本地图
  static asset(File image,
      {double width = 55,
      double height = 55,
      double borderWidth,
      Color borderColor}) {
    BoxDecoration decoration = borderColor != null
        ? BoxDecoration(
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular((width + borderWidth) * 0.5),
          )
        : null;

    return Container(
      width: width + borderWidth,
      height: height + borderWidth,
      decoration: decoration,
      child: ClipOval(
        child: Image.file(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
