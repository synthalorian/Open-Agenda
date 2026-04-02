// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 0;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      id: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      grade: fields[3] as int,
      section: fields[4] as String,
      email: fields[5] as String?,
      parentEmail: fields[6] as String?,
      parentPhone: fields[7] as String?,
      notes: fields[8] as String?,
      hasIEP: fields[9] as bool,
      isActive: fields[10] as bool,
      createdAt: fields[11] as DateTime,
      photoUrl: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.grade)
      ..writeByte(4)
      ..write(obj.section)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.parentEmail)
      ..writeByte(7)
      ..write(obj.parentPhone)
      ..writeByte(8)
      ..write(obj.notes)
      ..writeByte(9)
      ..write(obj.hasIEP)
      ..writeByte(10)
      ..write(obj.isActive)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.photoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentImpl _$$StudentImplFromJson(Map<String, dynamic> json) =>
    _$StudentImpl(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      grade: (json['grade'] as num).toInt(),
      section: json['section'] as String? ?? 'A',
      email: json['email'] as String?,
      parentEmail: json['parentEmail'] as String?,
      parentPhone: json['parentPhone'] as String?,
      notes: json['notes'] as String?,
      hasIEP: json['hasIEP'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$$StudentImplToJson(_$StudentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'grade': instance.grade,
      'section': instance.section,
      'email': instance.email,
      'parentEmail': instance.parentEmail,
      'parentPhone': instance.parentPhone,
      'notes': instance.notes,
      'hasIEP': instance.hasIEP,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'photoUrl': instance.photoUrl,
    };
