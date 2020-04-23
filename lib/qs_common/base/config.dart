

/// @author Qson
/// @create 2019/12/12
/// @Describe 项目配置，常量

class Config {
  static const bool DEBUG = !bool.fromEnvironment("dart.vm.product");

  static const PAGE_SIZE = 10;

  /// //////////////////////////////////////常量////////////////////////////////////// ///
  static const String API_KEY = "API_KEY";
  static const TOKEN_KEY = "token";
  static const USER_NAME_KEY = "user-name";
  static const PW_KEY = "user-pw";
  static const USER_BASIC_CODE = "user-basic-code";
  static const USER_INFO = "user-info";
  static const LANGUAGE_SELECT = "language-select";
  static const LANGUAGE_SELECT_NAME = "language-select-name";
  static const REFRESH_LANGUAGE = "refreshLanguageApp";
  static const THEME_COLOR = "theme-color";
  static const LOCALE = "locale";
  static const WXAppID = "wx8a7bd60279e2123c";

}

class Constant{
  static const String GET = "GET";
  static const String POST = "POST";
  static const String PUT = "PUT";
  static const String DELETE = "DELETE";
  static const TOKEN = "token";
  static const ACCOUNT = "ACCOUNT";
  static const USER_NAME = "USER_NAME";
  static const IS_LOGIN = "IS_LOGIN";
  static const WX_TYPE = 2;
  static const ALI_TYPE = 1;
  static const BANK_TYPE = 3;
}
