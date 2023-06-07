part 'bot.dart';
part 'browser.dart';
part 'model.dart';
part 'operating_systems.dart';

// A section contains the name of the product, its version and
// an optional comment.
class Section {
  String name = '';
  String version = '';
  List<String> comment = [];
}

// The UserAgent class contains all the info that can be extracted
// from the User-Agent string.
class UserAgent {
  String ua = '';
  String mozilla = '';
  String platform = '';
  String os = '';
  String localization = '';
  String model = '';
  Browser browser = Browser();
  bool bot = false;
  bool mobile = false;
  bool undecided = false;

  // Read from the given string until the given delimiter or the
  // end of the string have been reached.
  //
  // The first argument is the user agent string being parsed. The second
  // argument is a reference pointing to the current index of the user agent
  // string. The delimiter argument specifies which character is the delimiter
  // and the cat argument determines whether nested '(' should be ignored or
  // not.
  //
  // Returns a List<int> containing what has been read.
  static (List<int>, int) readUntil(
      String ua, int index, int delimiter, bool cat) {
    final buffer = <int>[];

    var i = index;
    var catalan = 0;
    for (; i < ua.length; i++) {
      if (ua.codeUnitAt(i) == delimiter) {
        if (catalan == 0) {
          index = i + 1;
          return (buffer, index);
        }
        catalan--;
      } else if (cat && ua.codeUnitAt(i) == '('.codeUnitAt(0)) {
        catalan++;
      }
      buffer.add(ua.codeUnitAt(i));
    }
    index = i + 1;
    return (buffer, index);
  }

  // Parse the given product, that is, just a name or a string
  // formatted as Name/Version.
  //
  // It returns two strings. The first string is the name of the product and the
  // second string contains the version of the product.
  static (String, String) parseProduct(List<int> product) {
    final prod = String.fromCharCodes(product);
    final results = prod.splitN('/', 2);
    if (results.length == 2) {
      return (results[0], results[1]);
    } else {
      return (prod, '');
    }
  }

  // Parse a section. A section is typically formatted as follows
  // "Name/Version (comment)". Both, the comment and the version are optional.
  //
  // The first argument is the user agent string being parsed. The second
  // argument is a reference pointing to the current index of the user agent
  // string.
  //
  // Returns a section containing the information that we could extract
  // from the last parsed section.
  static (Section, int) parseSection(String ua, int index) {
    final s = Section();

    List<int> buffer;
    // Check for empty products
    if (index < ua.length &&
        ua.codeUnitAt(index) != '('.codeUnitAt(0) &&
        ua.codeUnitAt(index) != '['.codeUnitAt(0)) {
      (buffer, index) = readUntil(ua, index, ' '.codeUnitAt(0), false);
      final product = parseProduct(buffer);
      s.name = product.$1;
      s.version = product.$2;
    }

    if (index < ua.length && ua.codeUnitAt(index) == '('.codeUnitAt(0)) {
      index++;
      (buffer, index) = readUntil(ua, index, ')'.codeUnitAt(0), true);
      s.comment = String.fromCharCodes(buffer).split('; ');
      index++;
    }

    // Discards any trailing data within square brackets
    if (index < ua.length && ua.codeUnitAt(index) == '['.codeUnitAt(0)) {
      index++;
      (_, index) = readUntil(ua, index, ']'.codeUnitAt(0), true);
      index++;
    }
    return (s, index);
  }

  // New parses the given User-Agent string and get the resulting UserAgent
  // object.
  //
  // Returns an UserAgent object that has been initialized after parsing
  // the given User-Agent string.
  static UserAgent parse(String ua) {
    final p = UserAgent()..ua = ua;
    final sections = <Section>[];
    var index = 0;
    while (index < ua.length) {
      Section s;
      (s, index) = parseSection(ua, index);
      if (!p.mobile && s.name == 'Mobile') {
        p.mobile = true;
      }
      sections.add(s);
    }

    if (sections.isNotEmpty) {
      if (sections[0].name == 'Mozilla') {
        p.mozilla = sections[0].version;
      }

      detectBrowser(p, sections);
      detectOS(p, sections[0]);
      detectModel(p, sections[0]);

      if (p.undecided) {
        checkBot(p, sections);
      }
    }
    return p;
  }
}

extension StringSplitNExtension on String {
  List<String> splitN(Pattern pattern, int limit) {
    if (limit == 0) return [];

    final arr = <String>[];
    var count = 0;
    var start = 0;
    int index;
    while ((index = indexOf(pattern, start)) > 0 && count < limit - 1) {
      count++;
      arr.add(substring(start, index));
      start = index + 1;
    }
    return arr..add(substring(start));
  }
}
