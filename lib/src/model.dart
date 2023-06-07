part of 'useragent.dart';

// detectModel some properties of the model from the given section.
void detectModel(UserAgent p, Section s) {
  if (!p.mobile) {
    return;
  }
  p.platform == 'iPhone' || p.platform == 'iPad' ? p.model = p.platform : null;
  // Android model
  if (s.name == 'Mozilla' && p.platform == 'Linux' && s.comment.length > 2) {
    var mostAndroidModel = s.comment[2];
    if (mostAndroidModel.contains('Android') ||
        mostAndroidModel.contains('Linux')) {
      mostAndroidModel = s.comment[s.comment.length - 1];
    }
    final tmp = mostAndroidModel.split('Build');
    if (tmp.isNotEmpty) {
      p.model = tmp[0].trim();
      return;
    }
  }
  // traverse all item
  for (var v in s.comment) {
    if (v.contains('Build')) {
      final tmp = v.split('Build');
      p.model = tmp[0].trim();
    }
  }
}
