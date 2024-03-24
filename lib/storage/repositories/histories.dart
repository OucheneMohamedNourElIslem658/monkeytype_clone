import 'dart:io';

import 'package:hive/hive.dart';

import '../models/history.dart';

class HistoriesRepository {
  Future<void> initHive() async {
    final path = Directory.current.path;
    Hive.init(path);
  }

  Future<void> addHistory(History history) async {
    final box = await Hive.openBox('histories');
    await box.add(history.toMap());
  }

  Future<List<History>> getHistories() async {
  final box = await Hive.openBox('histories');
  final List<History> histories = [];
  for (var i = 0; i < box.length; i++) {
    final dynamic historyData = box.getAt(i);
    final history = History.fromMap(historyData);
    histories.add(history);
  }
  return histories;
}

  Future<void> deleteHistory(int index) async {
    final box = await Hive.openBox('histories');
    await box.deleteAt(index);
  }

  Future<void> clearHistories() async {
    final box = await Hive.openBox('histories');
    await box.clear();
  }
}