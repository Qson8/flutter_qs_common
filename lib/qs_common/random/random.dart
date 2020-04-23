import 'dart:math';

/// @author Qson
/// @create 2019/12/12
/// @Describe 随机数
/// 
class RandomUtil {
  /// 随机数
  static const chars = "abcdefghijklmnopqrstuvwxyz0123456789";

  static String randomString(int strlen) {
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < strlen; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }
}
