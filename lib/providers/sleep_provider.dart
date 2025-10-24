import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/sleep_record.dart';

class SleepProvider with ChangeNotifier {
  final Box<SleepRecord> _box = Hive.box<SleepRecord>('sleep_records');
  List<SleepRecord> _records = [];

  SleepProvider() {
    _records = _box.values.toList();
  }

  List<SleepRecord> get records => _records;

  void addRecord(SleepRecord record) {
    _box.add(record);
    _records = _box.values.toList();
    notifyListeners();
  }

  void deleteRecord(int index) {
    _box.deleteAt(index);
    _records = _box.values.toList();
    notifyListeners();
  }
}
