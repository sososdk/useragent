part of 'useragent.dart';

var botFromSiteRegexp = RegExp(r'http[s]?://.+\.\w+');

// Get the name of the bot from the website that may be in the given comment. If
// there is no website in the comment, then an empty string is returned.
String getFromSite(List<String> comment) {
  if (comment.isEmpty) {
    return '';
  }

  // Where we should check the website.
  var idx = 2;
  if (comment.length < 3) {
    idx = 0;
  } else if (comment.length == 4) {
    idx = 3;
  }

  // Pick the site.
  final results = botFromSiteRegexp
      .allMatches(comment[idx])
      .map((m) => m.group(0))
      .nonNulls
      .toList();
  if (results.length == 1) {
    // If it's a simple comment, just return the name of the site.
    if (idx == 0) {
      return results[0];
    }
    // This is a large comment, usually the name will be in the previous
    // field of the comment.
    return comment[idx - 1].trim();
  }
  return '';
}

// Returns true if the info that we currently have corresponds to the Google
// or Bing mobile bot. This function also modifies some attributes in the
// receiver accordingly.
bool googleOrBingBot(UserAgent p) {
  // This is a hackish way to detect
  // Google's mobile bot (Googlebot, AdsBot-Google-Mobile, etc.)
  // (See https://support.google.com/webmasters/answer/1061943)
  // and Bing's mobile bot
  // (See https://www.bing.com/webmaster/help/which-crawlers-does-bing-use-8c184ec0)
  if (p.ua.contains('Google') || p.ua.contains('bingbot')) {
    p.platform = '';
    p.undecided = true;
  }
  return p.undecided;
}

// Returns true if we think that it is iMessage-Preview. This function also
// modifies some attributes in the receiver accordingly.
bool iMessagePreview(UserAgent p) {
  // iMessage-Preview doesn't advertise itself. We have a to rely on a hack
  // to detect it: it impersonates both facebook and twitter bots.
  // See https://medium.com/@siggi/apples-imessage-impersonates-twitter-facebook-bots-when-scraping-cef85b2cbb7d
  if (!p.ua.contains('facebookexternalhit')) {
    return false;
  }
  if (!p.ua.contains('Twitterbot')) {
    return false;
  }
  p.bot = true;
  p.browser.name = 'iMessage-Preview';
  p.browser.engine = '';
  p.browser.engineVersion = '';
  // We don't set the mobile flag because iMessage can be on iOS (mobile) or
  // macOS (not mobile).
  return true;
}

// Set the attributes of the receiver as given by the parameters. All the other
// parameters are set to empty.
void setSimple(UserAgent p, String name, String version, bool bot) {
  p.bot = bot;
  if (!bot) {
    p.mozilla = '';
  }
  p.browser.name = name;
  p.browser.version = version;
  p.browser.engine = '';
  p.browser.engineVersion = '';
  p.os = '';
  p.localization = '';
}

// Fix some values for some weird browsers.
void fixOther(UserAgent p, List<Section> sections) {
  if (sections.isNotEmpty) {
    p.browser.name = sections[0].name;
    p.browser.version = sections[0].version;
    p.mozilla = '';
  }
}

var botRegex = RegExp(
  r'(bot|crawler|sp(i|y)der|search|worm|fetch|nutch)',
  caseSensitive: false,
);

// Check if we're dealing with a bot or with some weird browser. If that is the
// case, the receiver will be modified accordingly.
bool checkBot(UserAgent p, List<Section> sections) {
  // If there's only one element, and it's doesn't have the Mozilla string,
  // check whether this is a bot or not.
  if (sections.length == 1 && sections[0].name != 'Mozilla') {
    p.mozilla = '';
    // Check whether the name has some suspicious "bot" or "crawler" in his
    // name.
    if (botRegex.hasMatch(sections[0].name)) {
      setSimple(p, sections[0].name, '', true);
      return true;
    }
    // Tough luck, let's try to see if it has a website in his comment.
    if (getFromSite(sections[0].comment) != '') {
      // First of all, this is a bot. Moreover, since it doesn't have the
      // Mozilla string, we can assume that the name and the version are
      // the ones from the first section.
      setSimple(p, sections[0].name, sections[0].version, true);
      return true;
    }
    // At this point we are sure that this is not a bot, but some weirdo.
    setSimple(p, sections[0].name, sections[0].version, false);
  } else {
    // Let's iterate over the available comments and check for a website.
    for (var v in sections) {
      if (getFromSite(v.comment) != '') {
        // Ok, we've got a bot name.
        final results = getFromSite(v.comment).splitN('/', 2);
        var version = '';
        if (results.length == 2) {
          version = results[1];
        }
        setSimple(p, results[0], version, true);
        return true;
      }
    }
    fixOther(p, sections);
  }
  return false;
}
