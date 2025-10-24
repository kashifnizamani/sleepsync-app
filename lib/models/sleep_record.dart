import 'package:hive/hive.dart';
part 'sleep_record.g.dart';


@HiveType(typeId: 0)
class SleepRecord extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final double duration; // in hours

  @HiveField(2)
  final String quality; // "Good", "Average", "Poor"

  SleepRecord({required this.date, required this.duration, required this.quality});
}
