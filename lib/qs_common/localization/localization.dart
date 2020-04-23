
import 'dart:ui';
import 'package:flutter/material.dart';
import 'string_base.dart';

export './localization.dart';
export './string_base.dart';
export './string_en.dart';
export './string_zh.dart';

///自定义多语言实现
class QSLocalizations {
  final Locale locale;

  QSLocalizations(this.locale);

  ///根据不同 locale.languageCode 加载不同语言对应
  ///GSYStringEn和GSYStringZh都继承了GSYStringBase
  static Map<String, QSStringBase> _localizedValues = {
    //'en': new YBStringEn(),
    //'zh': new YBStringZh(),
  };

  QSStringBase get currentLocalized {
    if (_localizedValues.containsKey(locale.languageCode)) {
      return _localizedValues[locale.languageCode];
    }
    return _localizedValues["en"];
  }

  ///通过 Localizations 加载当前的 GSYLocalizations
  ///获取对应的 GSYStringBase
  static QSLocalizations of(BuildContext context) {
    return Localizations.of(context, QSLocalizations);
  }

  ///通过 Localizations 加载当前的 GSYLocalizations
  ///获取对应的 GSYStringBase
  static QSStringBase i18n(BuildContext context) {
    return (Localizations.of(context,QSLocalizations) as QSLocalizations)
        .currentLocalized;
  }
}
