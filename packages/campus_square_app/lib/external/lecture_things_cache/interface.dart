import 'package:shared_preferences/shared_preferences.dart';

class LectureThingsCache {
  Future<void> saveLectureThings(String lecture, Set<String> items) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(lecture, items.toList());
  }

  Future<Set<String>?> getLectureThings(String lecture) async {
    final prefs = await SharedPreferences.getInstance();

    final items = prefs.getStringList(lecture);

    if (items == null) {
      return null;
    }
    return items.toSet();
  }

  Future<Map<String, Set<String>>> loadLectureThings() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    final lectureThings = <String, Set<String>>{};

    for (final key in keys) {
      try {
        final items = prefs.getStringList(key);
        if (items != null) {
          lectureThings[key] = items.toSet();
        }
      } catch (e) {
        print(e);
      }
    }

    return lectureThings;
  }
}