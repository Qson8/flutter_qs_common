import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'localization.dart';

/*
 * 多语言代理
 * Created by Qson
 * Date: 2019-08-15
 */
class QSLocalizationsDelegate extends LocalizationsDelegate<QSLocalizations> {

  QSLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    ///支持中文和英语
    return true;
  }

  ///根据locale，创建一个对象用于提供当前locale下的文本显示
  @override
  Future<QSLocalizations> load(Locale locale) {
    return new SynchronousFuture<QSLocalizations>(QSLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<QSLocalizations> old) {
    return false;
  }

  ///全局静态的代理
  static QSLocalizationsDelegate delegate = QSLocalizationsDelegate();
}
