part of 'useragent.dart';

final RegExp ie11Regexp = RegExp(r'^rv:(.+)$');

// Browser is a class containing all the information that we might be
// interested from the browser.
class Browser {
  // The name of the browser's engine.
  String engine = '';

  // The version of the browser's engine.
  String engineVersion = '';

  // The name of the browser.
  String name = '';

  // The version of the browser.
  String version = '';
}

// Extract all the information that we can get from the User-Agent string
// about the browser and update the receiver with this information.
//
// The function receives just one argument "sections", that contains the
// sections from the User-Agent string after being parsed.
void detectBrowser(UserAgent p, List<Section> sections) {
  final slen = sections.length;

  if (sections[0].name == 'Opera') {
    p.browser.name = 'Opera';
    p.browser.version = sections[0].version;
    p.browser.engine = 'Presto';
    if (slen > 1) {
      p.browser.engineVersion = sections[1].version;
    }
  } else if (sections[0].name == 'Dalvik') {
    // When Dalvik VM is in use, there is no browser info attached to ua.
    // Although browser is still a Mozilla/5.0 compatible.
    p.mozilla = '5.0';
  } else if (slen > 1) {
    final engine = sections[1];
    p.browser.engine = engine.name;
    p.browser.engineVersion = engine.version;
    if (slen > 2) {
      var sectionIndex = 2;
      // The version after the engine comment is empty on e.g. Ubuntu
      // platforms so if this is the case, let's use the next in line.
      if (sections[2].version == '' && slen > 3) {
        sectionIndex = 3;
      }
      p.browser.version = sections[sectionIndex].version;
      if (engine.name == 'AppleWebKit') {
        for (var comment in engine.comment) {
          if (comment.length > 5 &&
              (comment.startsWith('Googlebot') ||
                  comment.startsWith('bingbot'))) {
            p.undecided = true;
            break;
          }
        }
        switch (sections[slen - 1].name) {
          case 'Edge':
            p.browser.name = 'Edge';
            p.browser.version = sections[slen - 1].version;
            p.browser.engine = 'EdgeHTML';
            p.browser.engineVersion = '';
            break;
          case 'Edg':
            if (!p.undecided) {
              p.browser.name = 'Edge';
              p.browser.version = sections[slen - 1].version;
              p.browser.engine = 'AppleWebKit';
              p.browser.engineVersion = sections[slen - 2].version;
            }
            break;
          case 'OPR':
            p.browser.name = 'Opera';
            p.browser.version = sections[slen - 1].version;
            break;
          case 'Mobile':
            p.browser.name = 'Mobile App';
            p.browser.version = '';
            break;
          default:
            switch (sections[slen - 3].name) {
              case 'YaBrowser':
                p.browser.name = 'YaBrowser';
                p.browser.version = sections[slen - 3].version;
                break;
              case 'coc_coc_browser':
                p.browser.name = 'Coc Coc';
                p.browser.version = sections[slen - 3].version;
                break;
              default:
                switch (sections[slen - 2].name) {
                  case 'Electron':
                    p.browser.name = 'Electron';
                    p.browser.version = sections[slen - 2].version;
                    break;
                  case 'DuckDuckGo':
                    p.browser.name = 'DuckDuckGo';
                    p.browser.version = sections[slen - 2].version;
                    break;
                  case 'PhantomJS':
                    p.browser.name = 'PhantomJS';
                    p.browser.version = sections[slen - 2].version;
                    break;
                  default:
                    switch (sections[sectionIndex].name) {
                      case 'Chrome':
                      case 'CriOS':
                        p.browser.name = 'Chrome';
                        break;
                      case 'HeadlessChrome':
                        p.browser.name = 'Headless Chrome';
                        break;
                      case 'Chromium':
                        p.browser.name = 'Chromium';
                        break;
                      case 'GSA':
                        p.browser.name = 'Google App';
                        break;
                      case 'FxiOS':
                        p.browser.name = 'Firefox';
                        break;
                      default:
                        p.browser.name = 'Safari';
                    }
                }
            }
            // It's possible the google-bot emulates these now
            for (var comment in engine.comment) {
              if (comment.length > 5 &&
                  (comment.startsWith('Googlebot') ||
                      comment.startsWith('bingbot'))) {
                p.undecided = true;
                break;
              }
            }
        }
      } else if (engine.name == 'Gecko') {
        var name = sections[2].name;
        if (name == 'MRA' && slen > 4) {
          name = sections[4].name;
          p.browser.version = sections[4].version;
        }
        p.browser.name = name;
      } else if (engine.name == 'like' && sections[2].name == 'Gecko') {
        // This is the new user agent from Internet Explorer 11.
        p.browser.engine = 'Trident';
        p.browser.name = 'Internet Explorer';
        for (var c in sections[0].comment) {
          final version = ie11Regexp.firstMatch(c);
          if (version != null) {
            p.browser.version = version.group(1)!;
            return;
          }
        }
        p.browser.version = '';
      }
    }
  } else if (slen == 1 && sections[0].comment.length > 1) {
    final comment = sections[0].comment;
    if (comment[0] == 'compatible' && comment[1].startsWith('MSIE')) {
      p.browser.engine = 'Trident';
      p.browser.name = 'Internet Explorer';
      // The MSIE version may be reported as the compatibility version.
      // For IE 8 through 10, the Trident token is more accurate.
      // http://msdn.microsoft.com/en-us/library/ie/ms537503(v=vs.85).aspx#VerToken
      for (var v in comment) {
        if (v.startsWith('Trident/')) {
          switch (v.substring(8)) {
            case '4.0':
              p.browser.version = '8.0';
              break;
            case '5.0':
              p.browser.version = '9.0';
              break;
            case '6.0':
              p.browser.version = '10.0';
              break;
          }
          break;
        }
      }
      // If the Trident token is not provided, fall back to MSIE token.
      if (p.browser.version == '') {
        p.browser.version = comment[1].substring(4).trim();
      }
    }
  }
}
