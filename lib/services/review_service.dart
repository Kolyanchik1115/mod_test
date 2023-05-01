import 'package:shared_preferences/shared_preferences.dart';

class ReviewService {
  ReviewService._() {
    // onLogin();
  }

  static const String ratingField = 'user_rating';
  static const String countField = 'visit_count';
  static bool _reviewed = false;
  static late int count;

  static bool get needToShowRateUs => count == 2;

  static void toggle() {
    _reviewed = !_reviewed;
  }

  static Future<int?> _getCount(String fieldName) async {
    final prefs = await _sharedPrefs;
    return prefs.getInt(fieldName);
  }

  static Future<void> onLogin() async {
    count = await _getCount(countField) ?? 1;
    if (count > 2) return;
    _setCount(fieldName: countField, count: count + 1);
  }

  static Future<bool> get ifReviewed async {
    final field = await _getCount(ratingField);
    if (field != null) {
      return true;
    }
    return _reviewed;
  }

  static Future<SharedPreferences> get _sharedPrefs async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> setRating(int rating) async {
    await _setCount(fieldName: ratingField, count: rating);
    toggle();
  }

  static Future<void> _setCount({
    required String fieldName,
    required int count,
  }) async {
    final prefs = await _sharedPrefs;
    await prefs.setInt(countField, count);
  }
}
