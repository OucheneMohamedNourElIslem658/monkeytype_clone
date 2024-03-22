import 'package:hive/hive.dart';

import '../models/typing_racord.dart';

class HistoriesRepository {
  static const String _boxName = 'histories';

  Future<void> add(TypingRecord typingRecord) async {
    final box = await Hive.openBox<TypingRecord>(_boxName);
    await box.add(typingRecord);
  }

  Future<List<TypingRecord>> getAll() async {
    final box = await Hive.openBox<TypingRecord>(_boxName);
    return box.values.toList();
  }

  Future<void> delete(int index) async {
    final box = await Hive.openBox<TypingRecord>(_boxName);
    await box.deleteAt(index);
  }

  Future<void> deleteAll() async {
    final box = await Hive.openBox<TypingRecord>(_boxName);
    await box.clear();
  }
  
}