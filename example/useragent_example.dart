import 'package:useragent/useragent.dart';

void main() {
  final ua = UserAgent(
      'Mozilla/5.0 (Linux; U; Android 2.3.7; en-us; Nexus One Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1');
  print(ua.isMobile); // => true
  print(ua.isBot); // => false
  print(ua.mozilla); // => "5.0"
  print(ua.model); // => "Nexus One"

  print(ua.platform); // => "Linux"
  print(ua.os); // => "Android 2.3.7"

  print(ua.engine); // => "AppleWebKit"
  print(ua.engineVersion); // => "533.1"

  print(ua.browser); // => "Android"
  print(ua.browserVersion); // => "4.0"

  // Let's see an example with a bot.

  final bot = UserAgent(
      'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)');

  print(bot.isBot); // => true

  print(bot.browser); // => Googlebot
  print(bot.browserVersion); // => 2.1
}
