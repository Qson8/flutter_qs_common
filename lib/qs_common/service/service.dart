
import 'package:url_launcher/url_launcher.dart';

/// 打电话、发短信、邮箱等
class TelSmsService {
  void call(String number) => launch("tel:$number");
  void sendSms(String number) => launch("sms:$number");
  void sendEmail(String email) => launch("mailto:$email");
}