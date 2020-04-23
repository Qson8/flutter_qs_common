
import 'package:get_it/get_it.dart';
import 'service.dart';

/// 注册服务的工具类
/// app启动时调用 configLocator
final GetIt qs_locator = GetIt();
void configLocator() {
  qs_locator.registerSingleton(TelSmsService());
}