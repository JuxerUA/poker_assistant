import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage._();

  static final instance = Storage._();
  late final SharedPreferences prefs;

  int? get lastPlayersCount => prefs.getInt('lastPlayersCount');

  set lastPlayersCount(int? count) {
    if (count != null) {
      prefs.setInt('lastPlayersCount', count);
    }
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
  }
}
