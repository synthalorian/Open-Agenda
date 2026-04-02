// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Student _$StudentFromJson(Map<String, dynamic> json) {
  return _Student.fromJson(json);
}

/// @nodoc
mixin _$Student {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get firstName => throw _privateConstructorUsedError;
  @HiveField(2)
  String get lastName => throw _privateConstructorUsedError;
  @HiveField(3)
  int get grade => throw _privateConstructorUsedError;
  @HiveField(4)
  String get section => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get email => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get parentEmail => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get parentPhone => throw _privateConstructorUsedError;
  @HiveField(8)
  String? get notes => throw _privateConstructorUsedError;
  @HiveField(9)
  bool get hasIEP => throw _privateConstructorUsedError;
  @HiveField(10)
  bool get isActive => throw _privateConstructorUsedError;
  @HiveField(11)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(12)
  String? get photoUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StudentCopyWith<Student> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentCopyWith<$Res> {
  factory $StudentCopyWith(Student value, $Res Function(Student) then) =
      _$StudentCopyWithImpl<$Res, Student>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String firstName,
      @HiveField(2) String lastName,
      @HiveField(3) int grade,
      @HiveField(4) String section,
      @HiveField(5) String? email,
      @HiveField(6) String? parentEmail,
      @HiveField(7) String? parentPhone,
      @HiveField(8) String? notes,
      @HiveField(9) bool hasIEP,
      @HiveField(10) bool isActive,
      @HiveField(11) DateTime createdAt,
      @HiveField(12) String? photoUrl});
}

/// @nodoc
class _$StudentCopyWithImpl<$Res, $Val extends Student>
    implements $StudentCopyWith<$Res> {
  _$StudentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? grade = null,
    Object? section = null,
    Object? email = freezed,
    Object? parentEmail = freezed,
    Object? parentPhone = freezed,
    Object? notes = freezed,
    Object? hasIEP = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? photoUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as int,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      parentEmail: freezed == parentEmail
          ? _value.parentEmail
          : parentEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      parentPhone: freezed == parentPhone
          ? _value.parentPhone
          : parentPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      hasIEP: null == hasIEP
          ? _value.hasIEP
          : hasIEP // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentImplCopyWith<$Res> implements $StudentCopyWith<$Res> {
  factory _$$StudentImplCopyWith(
          _$StudentImpl value, $Res Function(_$StudentImpl) then) =
      __$$StudentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String firstName,
      @HiveField(2) String lastName,
      @HiveField(3) int grade,
      @HiveField(4) String section,
      @HiveField(5) String? email,
      @HiveField(6) String? parentEmail,
      @HiveField(7) String? parentPhone,
      @HiveField(8) String? notes,
      @HiveField(9) bool hasIEP,
      @HiveField(10) bool isActive,
      @HiveField(11) DateTime createdAt,
      @HiveField(12) String? photoUrl});
}

/// @nodoc
class __$$StudentImplCopyWithImpl<$Res>
    extends _$StudentCopyWithImpl<$Res, _$StudentImpl>
    implements _$$StudentImplCopyWith<$Res> {
  __$$StudentImplCopyWithImpl(
      _$StudentImpl _value, $Res Function(_$StudentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? grade = null,
    Object? section = null,
    Object? email = freezed,
    Object? parentEmail = freezed,
    Object? parentPhone = freezed,
    Object? notes = freezed,
    Object? hasIEP = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? photoUrl = freezed,
  }) {
    return _then(_$StudentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as int,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      parentEmail: freezed == parentEmail
          ? _value.parentEmail
          : parentEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      parentPhone: freezed == parentPhone
          ? _value.parentPhone
          : parentPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      hasIEP: null == hasIEP
          ? _value.hasIEP
          : hasIEP // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentImpl extends _Student {
  const _$StudentImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.firstName,
      @HiveField(2) required this.lastName,
      @HiveField(3) required this.grade,
      @HiveField(4) this.section = 'A',
      @HiveField(5) this.email,
      @HiveField(6) this.parentEmail,
      @HiveField(7) this.parentPhone,
      @HiveField(8) this.notes,
      @HiveField(9) this.hasIEP = false,
      @HiveField(10) this.isActive = true,
      @HiveField(11) required this.createdAt,
      @HiveField(12) this.photoUrl})
      : super._();

  factory _$StudentImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String firstName;
  @override
  @HiveField(2)
  final String lastName;
  @override
  @HiveField(3)
  final int grade;
  @override
  @JsonKey()
  @HiveField(4)
  final String section;
  @override
  @HiveField(5)
  final String? email;
  @override
  @HiveField(6)
  final String? parentEmail;
  @override
  @HiveField(7)
  final String? parentPhone;
  @override
  @HiveField(8)
  final String? notes;
  @override
  @JsonKey()
  @HiveField(9)
  final bool hasIEP;
  @override
  @JsonKey()
  @HiveField(10)
  final bool isActive;
  @override
  @HiveField(11)
  final DateTime createdAt;
  @override
  @HiveField(12)
  final String? photoUrl;

  @override
  String toString() {
    return 'Student(id: $id, firstName: $firstName, lastName: $lastName, grade: $grade, section: $section, email: $email, parentEmail: $parentEmail, parentPhone: $parentPhone, notes: $notes, hasIEP: $hasIEP, isActive: $isActive, createdAt: $createdAt, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.parentEmail, parentEmail) ||
                other.parentEmail == parentEmail) &&
            (identical(other.parentPhone, parentPhone) ||
                other.parentPhone == parentPhone) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.hasIEP, hasIEP) || other.hasIEP == hasIEP) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      firstName,
      lastName,
      grade,
      section,
      email,
      parentEmail,
      parentPhone,
      notes,
      hasIEP,
      isActive,
      createdAt,
      photoUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      __$$StudentImplCopyWithImpl<_$StudentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentImplToJson(
      this,
    );
  }
}

abstract class _Student extends Student {
  const factory _Student(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String firstName,
      @HiveField(2) required final String lastName,
      @HiveField(3) required final int grade,
      @HiveField(4) final String section,
      @HiveField(5) final String? email,
      @HiveField(6) final String? parentEmail,
      @HiveField(7) final String? parentPhone,
      @HiveField(8) final String? notes,
      @HiveField(9) final bool hasIEP,
      @HiveField(10) final bool isActive,
      @HiveField(11) required final DateTime createdAt,
      @HiveField(12) final String? photoUrl}) = _$StudentImpl;
  const _Student._() : super._();

  factory _Student.fromJson(Map<String, dynamic> json) = _$StudentImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get firstName;
  @override
  @HiveField(2)
  String get lastName;
  @override
  @HiveField(3)
  int get grade;
  @override
  @HiveField(4)
  String get section;
  @override
  @HiveField(5)
  String? get email;
  @override
  @HiveField(6)
  String? get parentEmail;
  @override
  @HiveField(7)
  String? get parentPhone;
  @override
  @HiveField(8)
  String? get notes;
  @override
  @HiveField(9)
  bool get hasIEP;
  @override
  @HiveField(10)
  bool get isActive;
  @override
  @HiveField(11)
  DateTime get createdAt;
  @override
  @HiveField(12)
  String? get photoUrl;
  @override
  @JsonKey(ignore: true)
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
