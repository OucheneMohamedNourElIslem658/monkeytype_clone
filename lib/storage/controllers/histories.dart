import 'package:get/get.dart';
import 'package:monkey_type_clone/storage/repositories/histories.dart';

import '../models/history.dart';

class HistoriesController extends GetxController {
  final histories = <History>[];
  final _historiesRepository = HistoriesRepository();

  void initHistories() async {
    await _historiesRepository.initHive();
    histories.assignAll(await _historiesRepository.getHistories());
  }

  Future<void> addHistory(History history) async {
    await _historiesRepository.addHistory(history);
    histories.add(history);
    update();
  }

  Future<void> deleteHistory(int index) async {
    await _historiesRepository.deleteHistory(index);
    histories.removeAt(index);
    update();
  }

  Future<void> clearHistories() async {
    await _historiesRepository.clearHistories();
    histories.clear();
    update();
  }

  @override
  void onInit() {
    initHistories();
    super.onInit();
  }
}