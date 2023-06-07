part of 'useragent.dart';

// OSInfo represents full information on the operating system extracted from the
// user agent.
class OSInfo {
  // Full name of the operating system. This is identical to the output of
  // ua.OS()
  String fullName = '';

  // Name of the operating system. This is sometimes a shorter version of the
  // operating system name, e.g. "Mac OS X" instead of "Intel Mac OS X"
  String name = '';

  // Operating system version, e.g. 7 for Windows 7 or 10.8 for Max OS X
  // Mountain Lion
  String version = '';
}

// Normalize the name of the operating system. By now, this just
// affects to Windows NT.
//
// Returns a string containing the normalized name for the Operating System.
String normalizeOS(String name) {
  final sp = name.splitN(' ', 3);
  if (sp.length != 3 || sp[1] != 'NT') {
    return name;
  }

  switch (sp[2]) {
    case '5.0':
      return 'Windows 2000';
    case '5.01':
      return 'Windows 2000, Service Pack 1 (SP1)';
    case '5.1':
      return 'Windows XP';
    case '5.2':
      return 'Windows XP x64 Edition';
    case '6.0':
      return 'Windows Vista';
    case '6.1':
      return 'Windows 7';
    case '6.2':
      return 'Windows 8';
    case '6.3':
      return 'Windows 8.1';
    case '10.0':
      return 'Windows 10';
  }
  return name;
}

// Guess the OS, the localization and if this is a mobile device for a
// Webkit-powered browser.
//
// The first argument p is a reference to the current UserAgent and the second
// argument is a List of strings containing the comment.
void webkit(UserAgent p, List<String> comment) {
  if (p.platform == 'webOS') {
    p.browser.name = p.platform;
    p.os = 'Palm';
    if (comment.length > 2) {
      p.localization = comment[2];
    }
    p.mobile = true;
  } else if (p.platform == 'Symbian') {
    p.mobile = true;
    p.browser.name = p.platform;
    p.os = comment[0];
  } else if (p.platform == 'Linux') {
    p.mobile = true;
    if (p.browser.name == 'Safari') {
      p.browser.name = 'Android';
    }
    if (comment.length > 1) {
      if (comment[1] == 'U' || comment[1] == 'arm_64') {
        if (comment.length > 2) {
          p.os = comment[2];
        } else {
          p.mobile = false;
          p.os = comment[0];
        }
      } else {
        p.os = comment[1];
      }
    }
    if (comment.length > 3) {
      p.localization = comment[3];
    } else if (comment.length == 3) {
      googleOrBingBot(p);
    }
  } else if (comment.isNotEmpty) {
    if (comment.length > 3) {
      p.localization = comment[3];
    }
    if (comment[0].startsWith('Windows NT')) {
      p.os = normalizeOS(comment[0]);
    } else if (comment.length < 2) {
      p.localization = comment[0];
    } else if (comment.length < 3) {
      if (!googleOrBingBot(p) && !iMessagePreview(p)) {
        p.os = normalizeOS(comment[1]);
      }
    } else {
      p.os = normalizeOS(comment[2]);
    }
    if (p.platform == 'BlackBerry') {
      p.browser.name = p.platform;
      if (p.os == 'Touch') {
        p.os = p.platform;
      }
    }
  }

  // Special case for Firefox on iPad, where the platform is advertised as
  // Macintosh instead of iPad
  if (p.platform == 'Macintosh' &&
      p.browser.engine == 'AppleWebKit' &&
      p.browser.name == 'Firefox') {
    p.platform = 'iPad';
    p.mobile = true;
  }
}

// Guess the OS, the localization and if this is a mobile device
// for a Gecko-powered browser.
//
// The first argument p is a reference to the current UserAgent and the second
// argument is a List of strings containing the comment.
void gecko(UserAgent p, List<String> comment) {
  if (comment.length > 1) {
    if (comment[1] == 'U' || comment[1] == 'arm_64') {
      if (comment.length > 2) {
        p.os = normalizeOS(comment[2]);
      } else {
        p.os = normalizeOS(comment[1]);
      }
    } else {
      if (p.platform.contains('Android')) {
        p.mobile = true;
        p.os = p.platform;
        p.platform = normalizeOS(comment[1]);
      } else if (comment[0] == 'Mobile' || comment[0] == 'Tablet') {
        p.mobile = true;
        p.os = 'FirefoxOS';
      } else {
        if (p.os == '') {
          p.os = normalizeOS(comment[1]);
        }
      }
    }
    // Only parse 4th comment as localization if it doesn't start with rv:.
    // For example Firefox on Ubuntu contains "rv:XX.X" in this field.
    if (comment.length > 3 && !comment[3].startsWith('rv:')) {
      p.localization = comment[3];
    }
  }
}

// Guess the OS, the localization and if this is a mobile device
// for Internet Explorer.
//
// The first argument p is a reference to the current UserAgent and the second
// argument is a List of strings containing the comment.
void trident(UserAgent p, List<String> comment) {
  // Internet Explorer only runs on Windows.
  p.platform = 'Windows';

  // The OS can be set before to handle a new case in IE11.
  if (p.os == '') {
    if (comment.length > 2) {
      p.os = normalizeOS(comment[2]);
    } else {
      p.os = 'Windows NT 4.0';
    }
  }

  // Last but not least, let's detect if it comes from a mobile device.
  for (var v in comment) {
    if (v.startsWith('IEMobile')) {
      p.mobile = true;
      return;
    }
  }
}

// Guess the OS, the localization and if this is a mobile device
// for Opera.
//
// The first argument p is a reference to the current UserAgent and the second
// argument is a List of strings containing the comment.
void opera(UserAgent p, List<String> comment) {
  final slen = comment.length;

  if (comment[0].startsWith('Windows')) {
    p.platform = 'Windows';
    p.os = normalizeOS(comment[0]);
    if (slen > 2) {
      if (slen > 3 && comment[2].startsWith('MRA')) {
        p.localization = comment[3];
      } else {
        p.localization = comment[2];
      }
    }
  } else {
    if (comment[0].startsWith('Android')) {
      p.mobile = true;
    }
    p.platform = comment[0];
    if (slen > 1) {
      p.os = comment[1];
      if (slen > 3) {
        p.localization = comment[3];
      }
    } else {
      p.os = comment[0];
    }
  }
}

// Guess the OS. Android browsers send Dalvik as the user agent in the
// request header.
//
// The first argument p is a reference to the current UserAgent and the second
// argument is a List of strings containing the comment.
void dalvik(UserAgent p, List<String> comment) {
  final slen = comment.length;

  if (comment[0].startsWith('Linux')) {
    p.platform = comment[0];
    if (slen > 2) {
      p.os = comment[2];
    }
    p.mobile = true;
  }
}

// Given the comment of the first section of the UserAgent string,
// get the platform.
String getPlatform(List<String> comment) {
  if (comment.isNotEmpty) {
    if (comment[0] != 'compatible') {
      if (comment[0].startsWith('Windows')) {
        return 'Windows';
      } else if (comment[0].startsWith('Symbian')) {
        return 'Symbian';
      } else if (comment[0].startsWith('webOS')) {
        return 'webOS';
      } else if (comment[0] == 'BB10') {
        return 'BlackBerry';
      }
      return comment[0];
    }
  }
  return '';
}

// Detect some properties of the OS from the given section.
void detectOS(UserAgent p, Section s) {
  if (s.name == 'Mozilla') {
    // Get the platform here. Be aware that IE11 provides a new format
    // that is not backwards-compatible with previous versions of IE.
    p.platform = getPlatform(s.comment);
    if (p.platform == 'Windows' && s.comment.isNotEmpty) {
      p.os = normalizeOS(s.comment[0]);
    }

    // And finally get the OS depending on the engine.
    switch (p.browser.engine) {
      case '':
        p.undecided = true;
        break;
      case 'Gecko':
        gecko(p, s.comment);
        break;
      case 'AppleWebKit':
        webkit(p, s.comment);
        break;
      case 'Trident':
        trident(p, s.comment);
        break;
    }
  } else if (s.name == 'Opera') {
    if (s.comment.isNotEmpty) {
      opera(p, s.comment);
    }
  } else if (s.name == 'Dalvik') {
    if (s.comment.isNotEmpty) {
      dalvik(p, s.comment);
    }
  } else if (s.name == 'okhttp') {
    p.mobile = true;
    p.browser.name = 'OkHttp';
    p.browser.version = s.version;
  } else {
    // Check whether this is a bot or just a weird browser.
    p.undecided = true;
  }
}

// Return OS name and version from a List of strings created from the full name
// of the OS.
(String, String) osName(List<String> osSplit) {
  String name;
  String version;
  if (osSplit.length == 1) {
    name = osSplit[0];
    version = '';
  } else {
    // Assume version is stored in the last part of the array.
    var nameSplit = osSplit.sublist(0, osSplit.length - 1);
    version = osSplit[osSplit.length - 1];

    // Nicer looking Mac OS X
    if (nameSplit.length >= 2 &&
        nameSplit[0] == 'Intel' &&
        nameSplit[1] == 'Mac') {
      nameSplit = nameSplit.sublist(1);
    }
    name = nameSplit.join(' ');

    if (version.contains('x86') || version.contains('i686')) {
      // x86_64 and i868 are not Linux versions but architectures
      version = '';
    } else if (version == 'X' && name == 'Mac OS') {
      // X is not a version for Mac OS.
      name = '$name $version';
      version = '';
    }
  }
  return (name, version);
}

extension UserAgentOSExtension on UserAgent {
// OSInfo returns combined information for the operating system.
  OSInfo osInfo() {
    // Special case for iPhone weirdness
    var os = this.os.replaceAll('like Mac OS X', '');
    os = os.replaceAll('CPU', '');
    os = os.trim();

    var osSplit = os.split(' ');

    // Special case for x64 edition of Windows
    if (os == 'Windows XP x64 Edition') {
      osSplit = osSplit.sublist(0, osSplit.length - 2);
    }

    String name;
    String version;
    (name, version) = osName(osSplit);

    // Special case for names that contain a forward slash version separator.
    if (name.contains('/')) {
      final s = name.split('/');
      name = s[0];
      version = s[1];
    }

    // Special case for versions that use underscores
    version = version.replaceAll('_', '.');

    return OSInfo()
      ..fullName = this.os
      ..name = name
      ..version = version;
  }
}
