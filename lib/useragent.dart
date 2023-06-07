// Package useragent implements an HTTP User Agent string parser. It defines
// the type UserAgent that contains all the information from the parsed string.
// It also implements the Parse function and getters for all the relevant
// information that has been extracted from a parsed User Agent string.
library useragent;

import 'src/useragent.dart' as internal;

class UserAgent {
  final internal.UserAgent ua;

  UserAgent(String ua) : ua = internal.UserAgent.parse(ua);

  // UA returns the original given user agent.
  String get userAgent => ua.ua;

  // Mozilla returns the mozilla version (it's how the User Agent string begins:
  // "Mozilla/5.0 ...", unless we're dealing with Opera, of course).
  String get mozilla => ua.mozilla;

  String get platform => ua.platform;

  String get os => ua.os;

  String get localization => ua.localization;

  String get model => ua.model;

  String get browser => ua.browser.name;

  String get browserVersion => ua.browser.version;

  String get engine => ua.browser.engine;

  String get engineVersion => ua.browser.engineVersion;

  // Bot returns true if it's a bot, false otherwise.
  bool get isBot => ua.bot;

  // Mobile returns true if it's a mobile device, false otherwise.
  bool get isMobile => ua.mobile;
}
