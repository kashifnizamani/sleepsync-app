// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SleepRecordAdapter extends TypeAdapter<SleepRecord> {
  @override
  final int typeId = 0;

  @override
  SleepRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SleepRecord(
      date: fields[0] as DateTime,
      duration: fields[1] as double,
      quality: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SleepRecord obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.duration)
      ..writeByte(2)
      ..write(obj.quality);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
