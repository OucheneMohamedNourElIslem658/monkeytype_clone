import 'package:get/get.dart';
import 'package:monkey_type_clone/storage/repositories/history.dart';

import '../models/typing_racord.dart';

class HistoriesController extends GetxController {
  final _historiesRepo = HistoriesRepository();

  final histories = <TypingRecord>[].obs;

  Future<List<TypingRecord>> _getAllRecords() async => _historiesRepo.getAll();

  Future<void> addRecord(TypingRecord typingRecord) async {
    histories.add(typingRecord);
    return _historiesRepo.add(typingRecord);
  }

  Future<void> deleteRecord(int index) async {
    histories.removeAt(index);
    return _historiesRepo.delete(index);
  }

  Future<void> deleteAllRecords() async {
    histories.clear();
    return _historiesRepo.deleteAll();
  }

  @override
  void onInit() {
    _getAllRecords().then((value) => histories.value = value);
    super.onInit();
  }
}