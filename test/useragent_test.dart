// ignore_for_file: lines_longer_than_80_chars

import 'package:test/test.dart';
import 'package:useragent/src/useragent.dart';

class UAString {
  String title;
  String ua;
  String expected;
  OSInfo? expectedOS;

  UAString({
    required this.title,
    required this.ua,
    required this.expected,
    this.expectedOS,
  });
}

final uastrings = [
  UAString(
    title: 'GoogleBot',
    ua: 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)',
    expected: 'Mozilla:5.0 Browser:Googlebot-2.1 Bot:true Mobile:false',
  ),
  UAString(
    title: 'GoogleBotSmartphone (iPhone)',
    ua: 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)',
    expected: 'Mozilla:5.0 Browser:Googlebot-2.1 Bot:true Mobile:true',
  ),
  UAString(
    title: 'GoogleBotSmartphone (Android)',
    ua: 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)',
    expected:
        'Mozilla:5.0 Model:Nexus 5X Browser:Googlebot-2.1 Bot:true Mobile:true',
  ),
  UAString(
    title: 'GoogleBotEmulateMozilla',
    ua: 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Safari/537.36',
    expected: 'Mozilla:5.0 Browser:Googlebot-2.1 Bot:true Mobile:false',
  ),
  UAString(
    title: 'BingBot',
    ua: 'Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)',
    expected: 'Mozilla:5.0 Browser:bingbot-2.0 Bot:true Mobile:false',
  ),
  UAString(
    title: 'BingBotSmartphone(iPhone)',
    ua: 'Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)',
    expected: 'Mozilla:5.0 Browser:bingbot-2.0 Bot:true Mobile:true',
  ),
  UAString(
    title: 'BingBotSmartphone(Android)',
    ua: 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36 Edg/80.0.345.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)',
    expected:
        'Mozilla:5.0 Model:Nexus 5X Browser:bingbot-2.0 Bot:true Mobile:true',
  ),
  UAString(
    title: 'BingBotEmulateMozilla',
    ua: 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/41.0.2272.96 Mobile Safari/537.36 Edg/80.0.345.0',
    expected: 'Mozilla:5.0 Browser:bingbot-2.0 Bot:true Mobile:true',
  ),
  UAString(
    title: 'BaiduBot',
    ua: 'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)',
    expected: 'Mozilla:5.0 Browser:Baiduspider-2.0 Bot:true Mobile:false',
  ),
  UAString(
    title: 'Twitterbot',
    ua: 'Twitterbot',
    expected: 'Browser:Twitterbot Bot:true Mobile:false',
  ),
  UAString(
    title: 'YahooBot',
    ua: 'Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)',
    expected: 'Mozilla:5.0 Browser:Yahoo! Slurp Bot:true Mobile:false',
  ),
  UAString(
    title: 'FacebookExternalHit',
    ua: 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)',
    expected: 'Browser:facebookexternalhit-1.1 Bot:true Mobile:false',
  ),
  UAString(
    title: 'FacebookPlatform',
    ua: 'facebookplatform/1.0 (+http://developers.facebook.com)',
    expected: 'Browser:facebookplatform-1.0 Bot:true Mobile:false',
  ),
  UAString(
    title: 'FaceBot',
    ua: 'Facebot',
    expected: 'Browser:Facebot Bot:true Mobile:false',
  ),
  UAString(
    title: 'NutchCVS',
    ua: 'NutchCVS/0.8-dev (Nutch; http://lucene.apache.org/nutch/bot.html; nutch-agent@lucene.apache.org)',
    expected: 'Browser:NutchCVS Bot:true Mobile:false',
  ),
  UAString(
    title: 'MJ12bot',
    ua: 'Mozilla/5.0 (compatible; MJ12bot/v1.2.4; http://www.majestic12.co.uk/bot.php?+)',
    expected: 'Mozilla:5.0 Browser:MJ12bot-v1.2.4 Bot:true Mobile:false',
  ),
  UAString(
    title: 'MJ12bot',
    ua: 'MJ12bot/v1.0.8 (http://majestic12.co.uk/bot.php?+)',
    expected: 'Browser:MJ12bot Bot:true Mobile:false',
  ),
  UAString(
    title: 'AhrefsBot',
    ua: 'Mozilla/5.0 (compatible; AhrefsBot/4.0; +http://ahrefs.com/robot/)',
    expected: 'Mozilla:5.0 Browser:AhrefsBot-4.0 Bot:true Mobile:false',
  ),
  UAString(
    title: 'AdsBotGoogle',
    ua: 'AdsBot-Google (+http://www.google.com/adsbot.html)',
    expected: 'Browser:AdsBot-Google Bot:true Mobile:false',
  ),
  UAString(
    title: 'AdsBotGoogleMobile',
    ua: 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1 (compatible; AdsBot-Google-Mobile; +http://www.google.com/mobile/adsbot.html)',
    expected: 'Mozilla:5.0 Browser:AdsBot-Google-Mobile Bot:true Mobile:true',
  ),
  UAString(
    title: 'APIs-Google',
    ua: 'APIs-Google (+https://developers.google.com/webmasters/APIs-Google.html)',
    expected: 'Browser:APIs-Google Bot:true Mobile:false',
  ),
  UAString(
    title: 'iMessage-preview',
    ua: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/601.2.4 (KHTML, like Gecko) Version/9.0.1 Safari/601.2.4 facebookexternalhit/1.1 Facebot Twitterbot/1.0',
    expected:
        'Mozilla:5.0 Platform:Macintosh Browser:iMessage-Preview-9.0.1 Bot:true Mobile:false',
  ),
  // Internet Explorer
  UAString(
    title: 'IE10',
    ua: 'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows 8 Browser:Internet Explorer-10.0 Engine:Trident Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Windows 8'
      ..name = 'Windows'
      ..version = '8',
  ),
  UAString(
    title: 'Tablet',
    ua: 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.2; ARM; Trident/6.0; Touch; .NET4.0E; .NET4.0C; Tablet PC 2.0)',
    expected:
        'Mozilla:4.0 Platform:Windows OS:Windows 8 Browser:Internet Explorer-10.0 Engine:Trident Bot:false Mobile:false',
  ),
  UAString(
    title: 'Touch',
    ua: 'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; ARM; Trident/6.0; Touch)',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows 8 Browser:Internet Explorer-10.0 Engine:Trident Bot:false Mobile:false',
  ),
  UAString(
    title: 'Phone',
    ua: 'Mozilla/4.0 (compatible; MSIE 7.0; Windows Phone OS 7.0; Trident/3.1; IEMobile/7.0; SAMSUNG; SGH-i917)',
    expected:
        'Mozilla:4.0 Platform:Windows OS:Windows Phone OS 7.0 Browser:Internet Explorer-7.0 Engine:Trident Bot:false Mobile:true',
    expectedOS: OSInfo()
      ..fullName = 'Windows Phone OS 7.0'
      ..name = 'Windows Phone OS'
      ..version = '7.0',
  ),
  UAString(
    title: 'IE6',
    ua: 'Mozilla/4.0 (compatible; MSIE6.0; Windows NT 5.0; .NET CLR 1.1.4322)',
    expected:
        'Mozilla:4.0 Platform:Windows OS:Windows 2000 Browser:Internet Explorer-6.0 Engine:Trident Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Windows 2000'
      ..name = 'Windows'
      ..version = '2000',
  ),
  UAString(
    title: 'IE8Compatibility',
    ua: 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; InfoPath.3; MS-RTC LM 8)',
    expected:
        'Mozilla:4.0 Platform:Windows OS:Windows 7 Browser:Internet Explorer-8.0 Engine:Trident Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Windows 7'
      ..name = 'Windows'
      ..version = '7',
  ),
  UAString(
    title: 'IE10Compatibility',
    ua: 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/6.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; InfoPath.3; MS-RTC LM 8)',
    expected:
        'Mozilla:4.0 Platform:Windows OS:Windows 7 Browser:Internet Explorer-10.0 Engine:Trident Bot:false Mobile:false',
  ),
  UAString(
    title: 'IE11Win81',
    ua: 'Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows 8.1 Browser:Internet Explorer-11.0 Engine:Trident Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Windows 8.1'
      ..name = 'Windows'
      ..version = '8.1',
  ),
  UAString(
    title: 'IE11Win7',
    ua: 'Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows 7 Browser:Internet Explorer-11.0 Engine:Trident Bot:false Mobile:false',
  ),
  UAString(
    title: 'IE11b32Win7b64',
    ua: 'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows 7 Browser:Internet Explorer-11.0 Engine:Trident Bot:false Mobile:false',
  ),
  UAString(
    title: 'IE11b32Win7b64MDDRJS',
    ua: 'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; MDDRJS; rv:11.0) like Gecko',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows 7 Browser:Internet Explorer-11.0 Engine:Trident Bot:false Mobile:false',
  ),
  UAString(
    title: 'IE11Compatibility',
    ua: 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.3; Trident/7.0)',
    expected:
        'Mozilla:4.0 Platform:Windows OS:Windows 8.1 Browser:Internet Explorer-7.0 Engine:Trident Bot:false Mobile:false',
  ),

  // Microsoft Edge
  UAString(
    title: 'EdgeDesktop',
    ua: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.10240',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows 10 Browser:Edge-12.10240 Engine:EdgeHTML Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Windows 10'
      ..name = 'Windows'
      ..version = '10',
  ),
  UAString(
    title: 'EdgeMobile',
    ua: 'Mozilla/5.0 (Windows Phone 10.0; Android 4.2.1; DEVICE INFO) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Mobile Safari/537.36 Edge/12.10240',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows Phone 10.0 Browser:Edge-12.10240 Engine:EdgeHTML Bot:false Mobile:true',
  ),

  // Microsoft Chromium Edge
  UAString(
    title: 'EdgeDesktop',
    ua: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36 Edg/83.0.478.37',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows 10 Browser:Edge-83.0.478.37 Engine:AppleWebKit-537.36 Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Windows 10'
      ..name = 'Windows'
      ..version = '10',
  ),

  // Gecko
  UAString(
    title: 'FirefoxMac',
    ua: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0b8) Gecko/20100101 Firefox/4.0b8',
    expected:
        'Mozilla:5.0 Platform:Macintosh OS:Intel Mac OS X 10.6 Browser:Firefox-4.0b8 Engine:Gecko-20100101 Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Intel Mac OS X 10.6'
      ..name = 'Mac OS X'
      ..version = '10.6',
  ),
  UAString(
    title: 'FirefoxMacLoc',
    ua: 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.13) Gecko/20101203 Firefox/3.6.13',
    expected:
        'Mozilla:5.0 Platform:Macintosh OS:Intel Mac OS X 10.6 Localization:en-US Browser:Firefox-3.6.13 Engine:Gecko-20101203 Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Intel Mac OS X 10.6'
      ..name = 'Mac OS X'
      ..version = '10.6',
  ),
  UAString(
    title: 'FirefoxLinux',
    ua: 'Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20100101 Firefox/17.0',
    expected:
        'Mozilla:5.0 Platform:X11 OS:Linux x86_64 Browser:Firefox-17.0 Engine:Gecko-20100101 Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Linux x86_64'
      ..name = 'Linux'
      ..version = '',
  ),
  UAString(
    title: 'FirefoxLinux - Ubuntu V50',
    ua: 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:50.0) Gecko/20100101 Firefox/50.0',
    expected:
        'Mozilla:5.0 Platform:X11 OS:Ubuntu Browser:Firefox-50.0 Engine:Gecko-20100101 Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Ubuntu'
      ..name = 'Ubuntu'
      ..version = '',
  ),
  UAString(
    title: 'FirefoxWin',
    ua: 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows XP Localization:en-US Browser:Firefox-2.0.0.14 Engine:Gecko-20080404 Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Windows XP'
      ..name = 'Windows'
      ..version = 'XP',
  ),
  UAString(
    title: 'Firefox29Win7',
    ua: 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0) Gecko/20100101 Firefox/29.0',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows 7 Browser:Firefox-29.0 Engine:Gecko-20100101 Bot:false Mobile:false',
  ),
  UAString(
    title: 'CaminoMac',
    ua: 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en; rv:1.8.1.14) Gecko/20080409 Camino/1.6 (like Firefox/2.0.0.14)',
    expected:
        'Mozilla:5.0 Platform:Macintosh OS:Intel Mac OS X Localization:en Browser:Camino-1.6 Engine:Gecko-20080409 Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Intel Mac OS X'
      ..name = 'Mac OS X'
      ..version = '',
  ),
  UAString(
    title: 'Iceweasel',
    ua: 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1) Gecko/20061024 Iceweasel/2.0 (Debian-2.0+dfsg-1)',
    expected:
        'Mozilla:5.0 Platform:X11 OS:Linux i686 Localization:en-US Browser:Iceweasel-2.0 Engine:Gecko-20061024 Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Linux i686'
      ..name = 'Linux'
      ..version = '',
  ),
  UAString(
    title: 'SeaMonkey',
    ua: 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.4) Gecko/20091017 SeaMonkey/2.0',
    expected:
        'Mozilla:5.0 Platform:Macintosh OS:Intel Mac OS X 10.6 Localization:en-US Browser:SeaMonkey-2.0 Engine:Gecko-20091017 Bot:false Mobile:false',
  ),
  UAString(
    title: 'AndroidFirefox',
    ua: 'Mozilla/5.0 (Android; Mobile; rv:17.0) Gecko/17.0 Firefox/17.0',
    expected:
        'Mozilla:5.0 Platform:Mobile OS:Android Browser:Firefox-17.0 Engine:Gecko-17.0 Bot:false Mobile:true',
  ),
  UAString(
    title: 'AndroidFirefoxNougat',
    ua: 'Mozilla/5.0 (Android 7.0; Mobile; rv:60.0) Gecko/60.0 Firefox/60.0',
    expected:
        'Mozilla:5.0 Platform:Mobile OS:Android 7.0 Browser:Firefox-60.0 Engine:Gecko-60.0 Bot:false Mobile:true',
  ),
  UAString(
    title: 'AndroidFirefoxTablet',
    ua: 'Mozilla/5.0 (Android; Tablet; rv:26.0) Gecko/26.0 Firefox/26.0',
    expected:
        'Mozilla:5.0 Platform:Tablet OS:Android Browser:Firefox-26.0 Engine:Gecko-26.0 Bot:false Mobile:true',
    expectedOS: OSInfo()
      ..fullName = 'Android'
      ..name = 'Android'
      ..version = '',
  ),
  UAString(
    title: 'FirefoxOS',
    ua: 'Mozilla/5.0 (Mobile; rv:26.0) Gecko/26.0 Firefox/26.0',
    expected:
        'Mozilla:5.0 Platform:Mobile OS:FirefoxOS Browser:Firefox-26.0 Engine:Gecko-26.0 Bot:false Mobile:true',
    expectedOS: OSInfo()
      ..fullName = 'FirefoxOS'
      ..name = 'FirefoxOS'
      ..version = '',
  ),
  UAString(
    title: 'FirefoxOSTablet',
    ua: 'Mozilla/5.0 (Tablet; rv:26.0) Gecko/26.0 Firefox/26.0',
    expected:
        'Mozilla:5.0 Platform:Tablet OS:FirefoxOS Browser:Firefox-26.0 Engine:Gecko-26.0 Bot:false Mobile:true',
  ),
  UAString(
    title: 'FirefoxWinXP',
    ua: 'Mozilla/5.0 (Windows NT 5.2; rv:31.0) Gecko/20100101 Firefox/31.0',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows XP x64 Edition Browser:Firefox-31.0 Engine:Gecko-20100101 Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Windows XP x64 Edition'
      ..name = 'Windows'
      ..version = 'XP',
  ),
  UAString(
    title: 'FirefoxMRA',
    ua: 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:24.0) Gecko/20130405 MRA 5.5 (build 02842) Firefox/24.0 (.NET CLR 3.5.30729)',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows XP Localization:en-US Browser:Firefox-24.0 Engine:Gecko-20130405 Bot:false Mobile:false',
  ),

  // Opera
  UAString(
    title: 'OperaMac',
    ua: 'Opera/9.27 (Macintosh; Intel Mac OS X; U; en)',
    expected:
        'Platform:Macintosh OS:Intel Mac OS X Localization:en Browser:Opera-9.27 Engine:Presto Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Intel Mac OS X'
      ..name = 'Mac OS X'
      ..version = '',
  ),
  UAString(
    title: 'OperaWin',
    ua: 'Opera/9.27 (Windows NT 5.1; U; en)',
    expected:
        'Platform:Windows OS:Windows XP Localization:en Browser:Opera-9.27 Engine:Presto Bot:false Mobile:false',
  ),
  UAString(
    title: 'OperaWinNoLocale',
    ua: 'Opera/9.80 (Windows NT 5.1) Presto/2.12.388 Version/12.10',
    expected:
        'Platform:Windows OS:Windows XP Browser:Opera-9.80 Engine:Presto-2.12.388 Bot:false Mobile:false',
  ),
  UAString(
    title: 'OperaWin2Comment',
    ua: 'Opera/9.80 (Windows NT 6.0; WOW64) Presto/2.12.388 Version/12.15',
    expected:
        'Platform:Windows OS:Windows Vista Browser:Opera-9.80 Engine:Presto-2.12.388 Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Windows Vista'
      ..name = 'Windows'
      ..version = 'Vista',
  ),
  UAString(
    title: 'OperaMinimal',
    ua: 'Opera/9.80',
    expected: 'Browser:Opera-9.80 Engine:Presto Bot:false Mobile:false',
  ),
  UAString(
    title: 'OperaFull',
    ua: 'Opera/9.80 (Windows NT 6.0; U; en) Presto/2.2.15 Version/10.10',
    expected:
        'Platform:Windows OS:Windows Vista Localization:en Browser:Opera-9.80 Engine:Presto-2.2.15 Bot:false Mobile:false',
  ),
  UAString(
    title: 'OperaLinux',
    ua: 'Opera/9.80 (X11; Linux x86_64) Presto/2.12.388 Version/12.10',
    expected:
        'Platform:X11 OS:Linux x86_64 Browser:Opera-9.80 Engine:Presto-2.12.388 Bot:false Mobile:false',
  ),
  UAString(
    title: 'OperaLinux - Ubuntu V41',
    ua: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36 OPR/41.0.2353.69',
    expected:
        'Mozilla:5.0 Platform:X11 OS:Linux x86_64 Browser:Opera-41.0.2353.69 Engine:AppleWebKit-537.36 Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Linux x86_64'
      ..name = 'Linux'
      ..version = '',
  ),
  UAString(
    title: 'OperaAndroid',
    ua: 'Opera/9.80 (Android 4.2.1; Linux; Opera Mobi/ADR-1212030829) Presto/2.11.355 Version/12.10',
    expected:
        'Platform:Android 4.2.1 OS:Linux Browser:Opera-9.80 Engine:Presto-2.11.355 Bot:false Mobile:true',
    expectedOS: OSInfo()
      ..fullName = 'Linux'
      ..name = 'Linux'
      ..version = '',
  ),
  UAString(
    title: 'OperaNested',
    ua: 'Opera/9.80 (Windows NT 5.1; MRA 6.0 (build 5831)) Presto/2.12.388 Version/12.10',
    expected:
        'Platform:Windows OS:Windows XP Browser:Opera-9.80 Engine:Presto-2.12.388 Bot:false Mobile:false',
  ),
  UAString(
    title: 'OperaMRA',
    ua: 'Opera/9.80 (Windows NT 6.1; U; MRA 5.8 (build 4139); en) Presto/2.9.168 Version/11.50',
    expected:
        'Platform:Windows OS:Windows 7 Localization:en Browser:Opera-9.80 Engine:Presto-2.9.168 Bot:false Mobile:false',
  ),

  // Yandex Browser
  UAString(
    title: 'YandexBrowserLinux',
    ua: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.99 YaBrowser/19.1.0.2494 (beta) Yowser/2.5 Safari/537.36',
    expected:
        'Mozilla:5.0 Platform:X11 OS:Linux x86_64 Browser:YaBrowser-19.1.0.2494 Engine:AppleWebKit-537.36 Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Linux x86_64'
      ..name = 'Linux'
      ..version = '',
  ),

  UAString(
    title: 'YandexBrowserWindows',
    ua: 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 YaBrowser/17.3.1.840 Yowser/2.5 Safari/537.36',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows 7 Browser:YaBrowser-17.3.1.840 Engine:AppleWebKit-537.36 Bot:false Mobile:false',
  ),

  UAString(
    title: 'YandexBrowserAndroid',
    ua: 'Mozilla/5.0 (Linux; Android 4.4.4; GT-I9300I Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 YaBrowser/17.9.0.523.00 Mobile Safari/537.36',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 4.4.4 Model:GT-I9300I Browser:YaBrowser-17.9.0.523.00 Engine:AppleWebKit-537.36 Bot:false Mobile:true',
  ),

  UAString(
    title: 'YandexBrowserIOS',
    ua: 'Mozilla/5.0 (iPad; CPU OS 10_1_1 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) Version/10.0 YaBrowser/16.11.1.716.11 Mobile/14B100 Safari/602.1',
    expected:
        'Mozilla:5.0 Platform:iPad OS:CPU OS 10_1_1 like Mac OS X Model:iPad Browser:YaBrowser-16.11.1.716.11 Engine:AppleWebKit-602.1.50 Bot:false Mobile:true',
  ),
  // Other
  UAString(
    title: 'Empty',
    ua: '',
    expected: 'Bot:false Mobile:false',
  ),
  UAString(
    title: 'Nil',
    ua: 'nil',
    expected: 'Browser:nil Bot:false Mobile:false',
  ),
  UAString(
    title: 'Compatible',
    ua: 'Mozilla/4.0 (compatible)',
    expected: 'Browser:Mozilla-4.0 Bot:false Mobile:false',
  ),
  UAString(
    title: 'Mozilla',
    ua: 'Mozilla/5.0',
    expected: 'Browser:Mozilla-5.0 Bot:false Mobile:false',
  ),
  UAString(
    title: 'Amaya',
    ua: 'amaya/9.51 libwww/5.4.0',
    expected: 'Browser:amaya-9.51 Engine:libwww-5.4.0 Bot:false Mobile:false',
  ),
  UAString(
    title: 'Rails',
    ua: 'Rails Testing',
    expected: 'Browser:Rails Engine:Testing Bot:false Mobile:false',
  ),
  UAString(
    title: 'Python',
    ua: 'Python-urllib/2.7',
    expected: 'Browser:Python-urllib-2.7 Bot:false Mobile:false',
  ),
  UAString(
    title: 'Curl',
    ua: 'curl/7.28.1',
    expected: 'Browser:curl-7.28.1 Bot:false Mobile:false',
  ),
  UAString(
    title: 'OkHttp',
    ua: 'okhttp/4.2.2',
    expected: 'Browser:OkHttp-4.2.2 Bot:false Mobile:true',
  ),

  // WebKit
  UAString(
    title: 'ChromeLinux',
    ua: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.97 Safari/537.11',
    expected:
        'Mozilla:5.0 Platform:X11 OS:Linux x86_64 Browser:Chrome-23.0.1271.97 Engine:AppleWebKit-537.11 Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Linux x86_64'
      ..name = 'Linux'
      ..version = '',
  ),
  UAString(
    title: 'ChromeLinux - Ubuntu V55',
    ua: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.75 Safari/537.36',
    expected:
        'Mozilla:5.0 Platform:X11 OS:Linux x86_64 Browser:Chrome-55.0.2883.75 Engine:AppleWebKit-537.36 Bot:false Mobile:false',
  ),
  UAString(
    title: 'ChromeWin7',
    ua: 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.168 Safari/535.19',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows 7 Browser:Chrome-18.0.1025.168 Engine:AppleWebKit-535.19 Bot:false Mobile:false',
  ),
  UAString(
    title: 'ChromeMinimal',
    ua: 'Mozilla/5.0 AppleWebKit/534.10 Chrome/8.0.552.215 Safari/534.10',
    expected:
        'Mozilla:5.0 Browser:Chrome-8.0.552.215 Engine:AppleWebKit-534.10 Bot:false Mobile:false',
  ),
  UAString(
    title: 'ChromeMac',
    ua: 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_5; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.231 Safari/534.10',
    expected:
        'Mozilla:5.0 Platform:Macintosh OS:Intel Mac OS X 10_6_5 Localization:en-US Browser:Chrome-8.0.552.231 Engine:AppleWebKit-534.10 Bot:false Mobile:false',
    expectedOS: OSInfo()
      ..fullName = 'Intel Mac OS X 10_6_5'
      ..name = 'Mac OS X'
      ..version = '10.6.5',
  ),
  UAString(
    title: 'Headless Chrome',
    ua: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/92.0.4515.107 Safari/537.36',
    expected:
        'Mozilla:5.0 Platform:X11 OS:Linux x86_64 Browser:Headless Chrome-92.0.4515.107 Engine:AppleWebKit-537.36 Bot:false Mobile:false',
  ),
  UAString(
    title: 'PhantomJS',
    ua: 'Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/538.1 (KHTML, like Gecko) PhantomJS/2.1.1 Safari/538.1',
    expected:
        'Mozilla:5.0 Platform:Unknown OS:Linux x86_64 Browser:PhantomJS-2.1.1 Engine:AppleWebKit-538.1 Bot:false Mobile:false',
  ),
  UAString(
    title: 'SafariMac',
    ua: 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; en-us) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16',
    expected:
        'Mozilla:5.0 Platform:Macintosh OS:Intel Mac OS X 10_6_3 Localization:en-us Browser:Safari-5.0 Engine:AppleWebKit-533.16 Bot:false Mobile:false',
  ),
  UAString(
    title: 'SafariWin',
    ua: 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en) AppleWebKit/526.9 (KHTML, like Gecko) Version/4.0dp1 Safari/526.8',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows XP Localization:en Browser:Safari-4.0dp1 Engine:AppleWebKit-526.9 Bot:false Mobile:false',
  ),
  UAString(
    title: 'iPhone7',
    ua: 'Mozilla/5.0 (iPhone; CPU iPhone OS 7_0_3 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11B511 Safari/9537.53',
    expected:
        'Mozilla:5.0 Platform:iPhone OS:CPU iPhone OS 7_0_3 like Mac OS X Model:iPhone Browser:Safari-7.0 Engine:AppleWebKit-537.51.1 Bot:false Mobile:true',
    expectedOS: OSInfo()
      ..fullName = 'CPU iPhone OS 7_0_3 like Mac OS X'
      ..name = 'iPhone OS'
      ..version = '7.0.3',
  ),
  UAString(
    title: 'iPhone',
    ua: 'Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420.1 (KHTML, like Gecko) Version/3.0 Mobile/4A102 Safari/419',
    expected:
        'Mozilla:5.0 Platform:iPhone OS:CPU like Mac OS X Localization:en Model:iPhone Browser:Safari-3.0 Engine:AppleWebKit-420.1 Bot:false Mobile:true',
  ),
  UAString(
    title: 'iPod',
    ua: 'Mozilla/5.0 (iPod; U; CPU like Mac OS X; en) AppleWebKit/420.1 (KHTML, like Gecko) Version/3.0 Mobile/4A102 Safari/419',
    expected:
        'Mozilla:5.0 Platform:iPod OS:CPU like Mac OS X Localization:en Browser:Safari-3.0 Engine:AppleWebKit-420.1 Bot:false Mobile:true',
  ),
  UAString(
    title: 'iPad',
    ua: 'Mozilla/5.0 (iPad; U; CPU OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B367 Safari/531.21.10',
    expected:
        'Mozilla:5.0 Platform:iPad OS:CPU OS 3_2 like Mac OS X Localization:en-us Model:iPad Browser:Safari-4.0.4 Engine:AppleWebKit-531.21.10 Bot:false Mobile:true',
  ),
  UAString(
    title: 'webOS',
    ua: 'Mozilla/5.0 (webOS/1.4.0; U; en-US) AppleWebKit/532.2 (KHTML, like Gecko) Version/1.0 Safari/532.2 Pre/1.1',
    expected:
        'Mozilla:5.0 Platform:webOS OS:Palm Localization:en-US Browser:webOS-1.0 Engine:AppleWebKit-532.2 Bot:false Mobile:true',
  ),
  UAString(
    title: 'Android',
    ua: 'Mozilla/5.0 (Linux; U; Android 1.5; de-; HTC Magic Build/PLAT-RC33) AppleWebKit/528.5+ (KHTML, like Gecko) Version/3.1.2 Mobile Safari/525.20.1',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 1.5 Localization:de- Model:HTC Magic Browser:Android-3.1.2 Engine:AppleWebKit-528.5+ Bot:false Mobile:true',
  ),
  UAString(
    title: 'BlackBerry',
    ua: 'Mozilla/5.0 (BlackBerry; U; BlackBerry 9800; en) AppleWebKit/534.1+ (KHTML, Like Gecko) Version/6.0.0.141 Mobile Safari/534.1+',
    expected:
        'Mozilla:5.0 Platform:BlackBerry OS:BlackBerry 9800 Localization:en Browser:BlackBerry-6.0.0.141 Engine:AppleWebKit-534.1+ Bot:false Mobile:true',
    expectedOS: OSInfo()
      ..fullName = 'BlackBerry 9800'
      ..name = 'BlackBerry'
      ..version = '9800',
  ),
  UAString(
    title: 'BB10',
    ua: 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.3+ (KHTML, like Gecko) Version/10.0.9.388 Mobile Safari/537.3+',
    expected:
        'Mozilla:5.0 Platform:BlackBerry OS:BlackBerry Browser:BlackBerry-10.0.9.388 Engine:AppleWebKit-537.3+ Bot:false Mobile:true',
  ),
  UAString(
    title: 'Ericsson',
    ua: 'Mozilla/5.0 (SymbianOS/9.4; U; Series60/5.0 Profile/MIDP-2.1 Configuration/CLDC-1.1) AppleWebKit/525 (KHTML, like Gecko) Version/3.0 Safari/525',
    expected:
        'Mozilla:5.0 Platform:Symbian OS:SymbianOS/9.4 Browser:Symbian-3.0 Engine:AppleWebKit-525 Bot:false Mobile:true',
    expectedOS: OSInfo()
      ..fullName = 'SymbianOS/9.4'
      ..name = 'SymbianOS'
      ..version = '9.4',
  ),
  UAString(
    title: 'ChromeAndroid',
    ua: 'Mozilla/5.0 (Linux; Android 4.2.1; Galaxy Nexus Build/JOP40D) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Mobile Safari/535.19',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 4.2.1 Model:Galaxy Nexus Browser:Chrome-18.0.1025.166 Engine:AppleWebKit-535.19 Bot:false Mobile:true',
  ),
  UAString(
    title: 'Chrome for iOS',
    ua: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_3_1 like Mac OS X) AppleWebKit/604.1.34 (KHTML, like Gecko) CriOS/67.0.3396.87 Mobile/15E302 Safari/604.1',
    expected:
        'Mozilla:5.0 Platform:iPhone OS:CPU iPhone OS 11_3_1 like Mac OS X Model:iPhone Browser:Chrome-67.0.3396.87 Engine:AppleWebKit-604.1.34 Bot:false Mobile:true',
  ),
  UAString(
    title: 'WebkitNoPlatform',
    ua: 'Mozilla/5.0 (en-us) AppleWebKit/525.13 (KHTML, like Gecko; Google Web Preview) Version/3.1 Safari/525.13',
    expected:
        'Mozilla:5.0 Platform:en-us Localization:en-us Browser:Safari-3.1 Engine:AppleWebKit-525.13 Bot:false Mobile:false',
  ),
  UAString(
    title: 'OperaWebkitMobile',
    ua: 'Mozilla/5.0 (Linux; Android 4.2.2; Galaxy Nexus Build/JDQ39) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.58 Mobile Safari/537.31 OPR/14.0.1074.57453',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 4.2.2 Model:Galaxy Nexus Browser:Opera-14.0.1074.57453 Engine:AppleWebKit-537.31 Bot:false Mobile:true',
  ),
  UAString(
    title: 'OperaWebkitDesktop',
    ua: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.58 Safari/537.31 OPR/14.0.1074.57453',
    expected:
        'Mozilla:5.0 Platform:X11 OS:Linux x86_64 Browser:Opera-14.0.1074.57453 Engine:AppleWebKit-537.31 Bot:false Mobile:false',
  ),
  UAString(
    title: 'ChromeNothingAfterU',
    ua: 'Mozilla/5.0 (Linux; U) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/537.4',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Linux Browser:Chrome-22.0.1229.79 Engine:AppleWebKit-537.4 Bot:false Mobile:false',
  ),
  UAString(
    title: 'SafariOnSymbian',
    ua: 'Mozilla/5.0 (SymbianOS/9.1; U; [en-us]) AppleWebKit/413 (KHTML, like Gecko) Safari/413',
    expected:
        'Mozilla:5.0 Platform:Symbian OS:SymbianOS/9.1 Browser:Symbian-413 Engine:AppleWebKit-413 Bot:false Mobile:true',
  ),
  UAString(
    title: 'Chromium - Ubuntu V49',
    ua: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.108 Safari/537.36',
    expected:
        'Mozilla:5.0 Platform:X11 OS:Linux x86_64 Browser:Chromium-49.0.2623.108 Engine:AppleWebKit-537.36 Bot:false Mobile:false',
  ),
  UAString(
    title: 'Chromium - Ubuntu V55',
    ua: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/53.0.2785.143 Chrome/53.0.2785.143 Safari/537.36',
    expected:
        'Mozilla:5.0 Platform:X11 OS:Linux x86_64 Browser:Chromium-53.0.2785.143 Engine:AppleWebKit-537.36 Bot:false Mobile:false',
  ),
  UAString(
    title: 'Firefox for iOS',
    ua: 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) FxiOS/1.0 Mobile/12F69 Safari/600.1.4',
    expected:
        'Mozilla:5.0 Platform:iPhone OS:CPU iPhone OS 8_3 like Mac OS X Model:iPhone Browser:Firefox-1.0 Engine:AppleWebKit-600.1.4 Bot:false Mobile:true',
  ),
  UAString(
    title: 'Firefox Focus for iOS',
    ua: 'Mozilla/5.0 (iPhone; CPU iPhone OS 12_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/7.0.4 Mobile/16B91 Safari/605.1.15',
    expected:
        'Mozilla:5.0 Platform:iPhone OS:CPU iPhone OS 12_1 like Mac OS X Model:iPhone Browser:Firefox-7.0.4 Engine:AppleWebKit-605.1.15 Bot:false Mobile:true',
  ),
  UAString(
    title: 'Firefox on iPad',
    ua: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/24.1 Safari/605.1.15',
    expected:
        'Mozilla:5.0 Platform:iPad OS:Intel Mac OS X 10.15 Model:iPad Browser:Firefox-24.1 Engine:AppleWebKit-605.1.15 Bot:false Mobile:true',
  ),
  UAString(
    title: 'Electron',
    ua: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) CozyDrive/3.17.0  Chrome/73.0.3683.119 Electron/5.0.0 Safari/537.36',
    expected:
        'Mozilla:5.0 Platform:Windows OS:Windows 10 Browser:Electron-5.0.0 Engine:AppleWebKit-537.36 Bot:false Mobile:false',
  ),
  UAString(
    title: 'Coc Coc',
    ua: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) coc_coc_browser/96.0.230 Chrome/90.0.4430.230 Safari/537.36',
    expected:
        'Mozilla:5.0 Platform:Macintosh OS:Intel Mac OS X 10_15_7 Browser:Coc Coc-96.0.230 Engine:AppleWebKit-537.36 Bot:false Mobile:false',
  ),
  UAString(
    title: 'LinkedInApp',
    ua: 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]',
    expected:
        'Mozilla:5.0 Platform:iPhone OS:CPU iPhone OS 14_6 like Mac OS X Model:iPhone Browser:Mobile App Engine:AppleWebKit-605.1.15 Bot:false Mobile:true',
  ),
  UAString(
    title: 'Google App for iOS',
    ua: 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/170.0.386351093 Mobile/15E148 Safari/604.1',
    expected:
        'Mozilla:5.0 Platform:iPhone OS:CPU iPhone OS 14_1 like Mac OS X Model:iPhone Browser:Google App-170.0.386351093 Engine:AppleWebKit-605.1.15 Bot:false Mobile:true',
  ),
  UAString(
    title: 'DuckDuckGo Browser for iOS',
    ua: 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.6 Mobile/15E148 DuckDuckGo/7 Safari/605.1.15',
    expected:
        'Mozilla:5.0 Platform:iPhone OS:CPU iPhone OS 14_6 like Mac OS X Model:iPhone Browser:DuckDuckGo-7 Engine:AppleWebKit-605.1.15 Bot:false Mobile:true',
  ),

  // Dalvik
  UAString(
    title: 'Dalvik - Dell:001DL',
    ua: 'Dalvik/1.2.0 (Linux; U; Android 2.2.2; 001DL Build/FRG83G)',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 2.2.2 Model:001DL Bot:false Mobile:true',
  ),
  UAString(
    title: 'Dalvik - HTC:001HT',
    ua: 'Dalvik/1.4.0 (Linux; U; Android 2.3.3; 001HT Build/GRI40)',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 2.3.3 Model:001HT Bot:false Mobile:true',
  ),
  UAString(
    title: 'Dalvik - ZTE:009Z',
    ua: 'Dalvik/1.4.0 (Linux; U; Android 2.3.4; 009Z Build/GINGERBREAD)',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 2.3.4 Model:009Z Bot:false Mobile:true',
  ),
  UAString(
    title: 'Dalvik - A850',
    ua: 'Dalvik/1.6.0 (Linux; U; Android 4.2.2; A850 Build/JDQ39) Configuration/CLDC-1.1; Opera Mini/att/4.2',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 4.2.2 Model:A850 Bot:false Mobile:true',
  ),
  UAString(
    title: 'Dalvik - Asus:T00Q',
    ua: 'Dalvik/1.6.0 (Linux; U; Android 4.4.2; ASUS_T00Q Build/KVT49L)/CLDC-1.1',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 4.4.2 Model:ASUS_T00Q Bot:false Mobile:true',
    expectedOS: OSInfo()
      ..fullName = 'Android 4.4.2'
      ..name = 'Android'
      ..version = '4.4.2',
  ),
  UAString(
    title: 'Dalvik - W2430',
    ua: 'Dalvik/1.6.0 (Linux; U; Android 4.0.4; W2430 Build/IMM76D)014; Profile/MIDP-2.1 Configuration/CLDC-1',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 4.0.4 Model:W2430 Bot:false Mobile:true',
  ),
  UAString(
    title: 'Samsung S5 Facebook App',
    ua: 'Mozilla/5.0 (Linux; Android 5.0; SM-G900P Build/LRX21T; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/43.0.2357.121 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/35.0.0.48.273;]',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 5.0 Localization:wv Model:SM-G900P Browser:Android-4.0 Engine:AppleWebKit-537.36 Bot:false Mobile:true',
  ),
  UAString(
    title: 'Facebook - No Browser Or OS',
    ua: '[FBAN/FB4A;FBAV/16.0.0.20.15;FBBV/4061184;FBDM/ UAString(density=1.5,width=540,height=960};FBLC/en_US;FB_FW/2;FBCR/MY CELCOM;FBPN/com.facebook.katana;FBDV/Lenovo A850+;FBSV/4.2.2;FBOP/1;FBCA/armeabi-v7a:armeabi;]',
    expected: 'Bot:false Mobile:false',
  ),

  // arm_64
  UAString(
    title: 'Samsung S7 Edge - YaBrowser',
    ua: 'Mozilla/5.0 (Linux; arm_64; Android 8.0.0; SM-G935F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 YaBrowser/19.12.3.101.00 Mobile Safari/537.36',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 8.0.0 Localization:SM-G935F Model:SM-G935F Browser:YaBrowser-19.12.3.101.00 Engine:AppleWebKit-537.36 Bot:false Mobile:true',
  ),

  // Get Phone Model
  UAString(
    title: 'HUAWEI P20 lite - YaBrowser',
    ua: 'Mozilla/5.0 (Linux; arm_64; Android 9; ANE-LX2J) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.6.114.00 Mobile Safari/537.36',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 9 Localization:ANE-LX2J Model:ANE-LX2J Browser:YaBrowser-20.2.6.114.00 Engine:AppleWebKit-537.36 Bot:false Mobile:true',
  ),
  UAString(
    title: 'OPPO R9sk',
    ua: 'Mozilla/5.0 (Linux; Android 7.1.1; OPPO R9sk) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.111 Mobile Safari/537.36',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 7.1.1 Model:OPPO R9sk Browser:Chrome-76.0.3809.111 Engine:AppleWebKit-537.36 Bot:false Mobile:true',
  ),
  UAString(
    title: 'Nexus One',
    ua: 'Mozilla/5.0 (Linux; U; Android 2.3.7; en-us; Nexus One Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 2.3.7 Localization:en-us Model:Nexus One Browser:Android-4.0 Engine:AppleWebKit-533.1 Bot:false Mobile:true',
  ),
  UAString(
    title: 'HUAWEIELE',
    ua: 'Mozilla/5.0 (Linux; Android 9; ELE-AL00 Build/HUAWEIELE-AL0001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/63.0.3239.83 Mobile Safari/537.36 T7/11.15 baiduboxapp/11.15.5.10 (Baidu; P1 9)',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 9 Localization:wv Model:ELE-AL00 Browser:Android-4.0 Engine:AppleWebKit-537.36 Bot:false Mobile:true',
  ),
  UAString(
    title: 'Redmi Note 3',
    ua: 'Mozilla/5.0 (Linux; U; Android 5.0.2; zh-cn; Redmi Note 3 Build/LRX22G) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/53.0.2785.146 Mobile Safari/537.36 XiaoMi/MiuiBrowser/8.8.7',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 5.0.2 Localization:zh-cn Model:Redmi Note 3 Browser:Android-4.0 Engine:AppleWebKit-537.36 Bot:false Mobile:true',
  ),
  UAString(
    title: 'Redmi K40',
    ua: 'Mozilla/5.0 (Linux; U; Android 12; zh-cn; M2012K11AC Build/SKQ1.211006.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/89.0.4389.116 Mobile Safari/537.36 XiaoMi/MiuiBrowser/16.4.20 swan-mibrowser',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 12 Localization:zh-cn Model:M2012K11AC Browser:Android-4.0 Engine:AppleWebKit-537.36 Bot:false Mobile:true',
  ),
  UAString(
    title: 'XiaoMi 6',
    ua: 'Mozilla/5.0 (Linux; Android 8.0.0; MI 6 Build/OPR1.170623.027; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/76.0.3809.89 Mobile Safari/537.36 T7/11.12 swan/2.11.0 baiduboxapp/11.15.0.0 (Baidu; P1 8.0.0)',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 8.0.0 Localization:wv Model:MI 6 Browser:Android-4.0 Engine:AppleWebKit-537.36 Bot:false Mobile:true',
  ),
  UAString(
    title: 'HTC_Wildfire_A3333',
    ua: 'Mozilla/5.0 (Linux; U; Android 2.2.1; zh-cn; HTC_Wildfire_A3333 Build/FRG83D) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1',
    expected:
        'Mozilla:5.0 Platform:Linux OS:Android 2.2.1 Localization:zh-cn Model:HTC_Wildfire_A3333 Browser:Android-4.0 Engine:AppleWebKit-533.1 Bot:false Mobile:true',
  ),
];

String beautify(UserAgent ua) {
  var s = '';
  if (ua.mozilla.isNotEmpty) {
    s += 'Mozilla:${ua.mozilla} ';
  }
  if (ua.platform.isNotEmpty) {
    s += 'Platform:${ua.platform} ';
  }
  if (ua.os.isNotEmpty) {
    s += 'OS:${ua.os} ';
  }
  if (ua.localization.isNotEmpty) {
    s += 'Localization:${ua.localization} ';
  }
  if (ua.model.isNotEmpty) {
    s += 'Model:${ua.model} ';
  }
  var str1 = ua.browser.name;
  var str2 = ua.browser.version;
  if (str1.isNotEmpty) {
    s += 'Browser:$str1';
    if (str2.isNotEmpty) {
      s += '-$str2 ';
    } else {
      s += ' ';
    }
  }
  str1 = ua.browser.engine;
  str2 = ua.browser.engineVersion;
  if (str1.isNotEmpty) {
    s += 'Engine:$str1';
    if (str2.isNotEmpty) {
      s += '-$str2 ';
    } else {
      s += ' ';
    }
  }
  s += 'Bot:${ua.bot} ';
  s += 'Mobile:${ua.mobile}';
  return s;
}

void main() {
  group('A group of tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('UserAgent', () {
      for (var e in uastrings) {
        final ua = UserAgent.parse(e.ua);
        expect(beautify(ua), e.expected);
        if (e.expectedOS != null) {
          final os = ua.osInfo();
          expect(
            'FullName: ${e.expectedOS!.fullName} Name: ${e.expectedOS!.name} Version: ${e.expectedOS!.version}',
            'FullName: ${os.fullName} Name: ${os.name} Version: ${os.version}',
          );
        }
      }
    });
  });
}
