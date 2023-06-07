<p align="center">
  <a href="https://pub.dev/packages/useragent" rel="nofollow"><img alt="MIT" src="https://img.shields.io/pub/v/useragent.svg?style=flat" style="max-width:100%;"></a>
  <a href="https://en.wikipedia.org/wiki/Apache_License#Apache_License_2.0" rel="nofollow"><img alt="MIT" src="https://img.shields.io/badge/license-APACHE2.0-blue.svg" style="max-width:100%;"></a>
</p>

## Features

UserAgent is a dart library that parses HTTP User Agents inspired
by [useragent](https://github.com/mssola/useragent). As an example:

```dart
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
```

# License

```
Copyright 2023 sososdk

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```