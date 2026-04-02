// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iep_goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IEPGoalAdapter extends TypeAdapter<IEPGoal> {
  @override
  final int typeId = 7;

  @override
  IEPGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IEPGoal(
      id: fields[0] as String,
      studentId: fields[1] as String,
      goalText: fields[2] as String,
      category: fields[3] as String,
      targetDate: fields[4] as DateTime,
      progressPercent: fields[5] as double,
      accommodations: (fields[6] as List).cast<String>(),
      notes: fields[7] as String?,
      status: fields[8] as GoalStatus,
      createdAt: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, IEPGoal obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.studentId)
      ..writeByte(2)
      ..write(obj.goalText)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.targetDate)
      ..writeByte(5)
      ..write(obj.progressPercent)
      ..writeByte(6)
      ..write(obj.accommodations)
      ..writeByte(7)
      ..write(obj.notes)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IEPGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IEPProgressNoteAdapter extends TypeAdapter<IEPProgressNote> {
  @override
  final int typeId = 9;

  @override
  IEPProgressNote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IEPProgressNote(
      id: fields[0] as String,
      goalId: fields[1] as String,
      note: fields[2] as String,
      progressPercent: fields[3] as double,
      recordedAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, IEPProgressNote obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.goalId)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.progressPercent)
      ..writeByte(4)
      ..write(obj.recordedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IEPProgressNoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GoalStatusAdapter extends TypeAdapter<GoalStatus> {
  @override
  final int typeId = 8;

  @override
  GoalStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GoalStatus.active;
      case 1:
        return GoalStatus.met;
      case 2:
        return GoalStatus.notMet;
      case 3:
        return GoalStatus.revised;
      default:
        return GoalStatus.active;
    }
  }

  @override
  void write(BinaryWriter writer, GoalStatus obj) {
    switch (obj) {
      case GoalStatus.active:
        writer.writeByte(0);
        break;
      case GoalStatus.met:
        writer.writeByte(1);
        break;
      case GoalStatus.notMet:
        writer.writeByte(2);
        break;
      case GoalStatus.revised:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IEPGoalImpl _$$IEPGoalImplFromJson(Map<String, dynamic> json) =>
    _$IEPGoalImpl(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      goalText: json['goalText'] as String,
      category: json['category'] as String,
      targetDate: DateTime.parse(json['targetDate'] as String),
      progressPercent: (json['progressPercent'] as num?)?.toDouble() ?? 0.0,
      accommodations: (json['accommodations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      notes: json['notes'] as String?,
      status: $enumDecodeNullable(_$GoalStatusEnumMap, json['status']) ??
          GoalStatus.active,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$IEPGoalImplToJson(_$IEPGoalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'goalText': instance.goalText,
      'category': instance.category,
      'targetDate': instance.targetDate.toIso8601String(),
      'progressPercent': instance.progressPercent,
      'accommodations': instance.accommodations,
      'notes': instance.notes,
      'status': _$GoalStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$GoalStatusEnumMap = {
  GoalStatus.active: 'active',
  GoalStatus.met: 'met',
  GoalStatus.notMet: 'notMet',
  GoalStatus.revised: 'revised',
};

_$IEPProgressNoteImpl _$$IEPProgressNoteImplFromJson(
        Map<String, dynamic> json) =>
    _$IEPProgressNoteImpl(
      id: json['id'] as String,
      goalId: json['goalId'] as String,
      note: json['note'] as String,
      progressPercent: (json['progressPercent'] as num).toDouble(),
      recordedAt: DateTime.parse(json['recordedAt'] as String),
    );

Map<String, dynamic> _$$IEPProgressNoteImplToJson(
        _$IEPProgressNoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'goalId': instance.goalId,
      'note': instance.note,
      'progressPercent': instance.progressPercent,
      'recordedAt': instance.recordedAt.toIso8601String(),
    };
