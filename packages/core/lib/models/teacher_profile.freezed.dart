// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teacher_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TeacherProfile _$TeacherProfileFromJson(Map<String, dynamic> json) {
  return _TeacherProfile.fromJson(json);
}

/// @nodoc
mixin _$TeacherProfile {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get email => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get school => throw _privateConstructorUsedError;
  @HiveField(4)
  List<String> get subjects => throw _privateConstructorUsedError;
  @HiveField(5)
  List<int> get gradesTaught => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get pin => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeacherProfileCopyWith<TeacherProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeacherProfileCopyWith<$Res> {
  factory $TeacherProfileCopyWith(
          TeacherProfile value, $Res Function(TeacherProfile) then) =
      _$TeacherProfileCopyWithImpl<$Res, TeacherProfile>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String? email,
      @HiveField(3) String? school,
      @HiveField(4) List<String> subjects,
      @HiveField(5) List<int> gradesTaught,
      @HiveField(6) String? pin});
}

/// @nodoc
class _$TeacherProfileCopyWithImpl<$Res, $Val extends TeacherProfile>
    implements $TeacherProfileCopyWith<$Res> {
  _$TeacherProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = freezed,
    Object? school = freezed,
    Object? subjects = null,
    Object? gradesTaught = null,
    Object? pin = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      school: freezed == school
          ? _value.school
          : school // ignore: cast_nullable_to_non_nullable
              as String?,
      subjects: null == subjects
          ? _value.subjects
          : subjects // ignore: cast_nullable_to_non_nullable
              as List<String>,
      gradesTaught: null == gradesTaught
          ? _value.gradesTaught
          : gradesTaught // ignore: cast_nullable_to_non_nullable
              as List<int>,
      pin: freezed == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeacherProfileImplCopyWith<$Res>
    implements $TeacherProfileCopyWith<$Res> {
  factory _$$TeacherProfileImplCopyWith(_$TeacherProfileImpl value,
          $Res Function(_$TeacherProfileImpl) then) =
      __$$TeacherProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String? email,
      @HiveField(3) String? school,
      @HiveField(4) List<String> subjects,
      @HiveField(5) List<int> gradesTaught,
      @HiveField(6) String? pin});
}

/// @nodoc
class __$$TeacherProfileImplCopyWithImpl<$Res>
    extends _$TeacherProfileCopyWithImpl<$Res, _$TeacherProfileImpl>
    implements _$$TeacherProfileImplCopyWith<$Res> {
  __$$TeacherProfileImplCopyWithImpl(
      _$TeacherProfileImpl _value, $Res Function(_$TeacherProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = freezed,
    Object? school = freezed,
    Object? subjects = null,
    Object? gradesTaught = null,
    Object? pin = freezed,
  }) {
    return _then(_$TeacherProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      school: freezed == school
          ? _value.school
          : school // ignore: cast_nullable_to_non_nullable
              as String?,
      subjects: null == subjects
          ? _value._subjects
          : subjects // ignore: cast_nullable_to_non_nullable
              as List<String>,
      gradesTaught: null == gradesTaught
          ? _value._gradesTaught
          : gradesTaught // ignore: cast_nullable_to_non_nullable
              as List<int>,
      pin: freezed == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeacherProfileImpl implements _TeacherProfile {
  const _$TeacherProfileImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) this.email,
      @HiveField(3) this.school,
      @HiveField(4) final List<String> subjects = const [],
      @HiveField(5) final List<int> gradesTaught = const [],
      @HiveField(6) this.pin})
      : _subjects = subjects,
        _gradesTaught = gradesTaught;

  factory _$TeacherProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeacherProfileImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String? email;
  @override
  @HiveField(3)
  final String? school;
  final List<String> _subjects;
  @override
  @JsonKey()
  @HiveField(4)
  List<String> get subjects {
    if (_subjects is EqualUnmodifiableListView) return _subjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subjects);
  }

  final List<int> _gradesTaught;
  @override
  @JsonKey()
  @HiveField(5)
  List<int> get gradesTaught {
    if (_gradesTaught is EqualUnmodifiableListView) return _gradesTaught;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gradesTaught);
  }

  @override
  @HiveField(6)
  final String? pin;

  @override
  String toString() {
    return 'TeacherProfile(id: $id, name: $name, email: $email, school: $school, subjects: $subjects, gradesTaught: $gradesTaught, pin: $pin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeacherProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.school, school) || other.school == school) &&
            const DeepCollectionEquality().equals(other._subjects, _subjects) &&
            const DeepCollectionEquality()
                .equals(other._gradesTaught, _gradesTaught) &&
            (identical(other.pin, pin) || other.pin == pin));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      email,
      school,
      const DeepCollectionEquality().hash(_subjects),
      const DeepCollectionEquality().hash(_gradesTaught),
      pin);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeacherProfileImplCopyWith<_$TeacherProfileImpl> get copyWith =>
      __$$TeacherProfileImplCopyWithImpl<_$TeacherProfileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeacherProfileImplToJson(
      this,
    );
  }
}

abstract class _TeacherProfile implements TeacherProfile {
  const factory _TeacherProfile(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) final String? email,
      @HiveField(3) final String? school,
      @HiveField(4) final List<String> subjects,
      @HiveField(5) final List<int> gradesTaught,
      @HiveField(6) final String? pin}) = _$TeacherProfileImpl;

  factory _TeacherProfile.fromJson(Map<String, dynamic> json) =
      _$TeacherProfileImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String? get email;
  @override
  @HiveField(3)
  String? get school;
  @override
  @HiveField(4)
  List<String> get subjects;
  @override
  @HiveField(5)
  List<int> get gradesTaught;
  @override
  @HiveField(6)
  String? get pin;
  @override
  @JsonKey(ignore: true)
  _$$TeacherProfileImplCopyWith<_$TeacherProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
