// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_plan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonPlanAdapter extends TypeAdapter<LessonPlan> {
  @override
  final int typeId = 6;

  @override
  LessonPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonPlan(
      id: fields[0] as String,
      title: fields[1] as String,
      subject: fields[2] as String,
      date: fields[3] as DateTime,
      startTime: fields[4] as String,
      endTime: fields[5] as String,
      objective: fields[6] as String,
      materials: (fields[7] as List).cast<String>(),
      activities: fields[8] as String,
      assessment: fields[9] as String?,
      notes: fields[10] as String?,
      isCompleted: fields[11] as bool,
      createdAt: fields[12] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LessonPlan obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subject)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.startTime)
      ..writeByte(5)
      ..write(obj.endTime)
      ..writeByte(6)
      ..write(obj.objective)
      ..writeByte(7)
      ..write(obj.materials)
      ..writeByte(8)
      ..write(obj.activities)
      ..writeByte(9)
      ..write(obj.assessment)
      ..writeByte(10)
      ..write(obj.notes)
      ..writeByte(11)
      ..write(obj.isCompleted)
      ..writeByte(12)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonPlanImpl _$$LessonPlanImplFromJson(Map<String, dynamic> json) =>
    _$LessonPlanImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      subject: json['subject'] as String,
      date: DateTime.parse(json['date'] as String),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      objective: json['objective'] as String,
      materials: (json['materials'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      activities: json['activities'] as String,
      assessment: json['assessment'] as String?,
      notes: json['notes'] as String?,
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$LessonPlanImplToJson(_$LessonPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subject': instance.subject,
      'date': instance.date.toIso8601String(),
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'objective': instance.objective,
      'materials': instance.materials,
      'activities': instance.activities,
      'assessment': instance.assessment,
      'notes': instance.notes,
      'isCompleted': instance.isCompleted,
      'createdAt': instance.createdAt.toIso8601String(),
    };
