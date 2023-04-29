import 'package:shared_preferences/shared_preferences.dart';

class ReviewService {
  ReviewService._();
  static const String ratingField = 'user_rating';
  static const String countField = 'visit_count';
  static bool _reviewed = false;
  static bool _isSecond = false;

  static void toggle() {
    _reviewed = !_reviewed;
  }

  static void counter() {
    _isSecond = !_isSecond;
  }

  static Future<bool> get ifSecond async {
    final prefs = await _sharedPrefs;

    final field = prefs.getBool(countField);
    if (field == null) {
      return false;
    }
    return field;
  }

  static Future<bool> get ifReviewed async {
    final prefs = await _sharedPrefs;
    final field = prefs.getInt(ratingField);
    if (field != null) {
      return true;
    }
    return _reviewed;
  }

  static Future<SharedPreferences> get _sharedPrefs async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> setRating(int rating) async {
    final prefs = await _sharedPrefs;
    await prefs.setInt(ratingField, rating);
    toggle();
  }

  static Future<void> setCount(int count) async {
    final prefs = await _sharedPrefs;
    await prefs.setInt(countField, count);
    counter();
  }
}
