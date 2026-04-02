// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LessonPlan _$LessonPlanFromJson(Map<String, dynamic> json) {
  return _LessonPlan.fromJson(json);
}

/// @nodoc
mixin _$LessonPlan {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  String get subject => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime get date => throw _privateConstructorUsedError;
  @HiveField(4)
  String get startTime => throw _privateConstructorUsedError;
  @HiveField(5)
  String get endTime => throw _privateConstructorUsedError;
  @HiveField(6)
  String get objective => throw _privateConstructorUsedError;
  @HiveField(7)
  List<String> get materials => throw _privateConstructorUsedError;
  @HiveField(8)
  String get activities => throw _privateConstructorUsedError;
  @HiveField(9)
  String? get assessment => throw _privateConstructorUsedError;
  @HiveField(10)
  String? get notes => throw _privateConstructorUsedError;
  @HiveField(11)
  bool get isCompleted => throw _privateConstructorUsedError;
  @HiveField(12)
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LessonPlanCopyWith<LessonPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonPlanCopyWith<$Res> {
  factory $LessonPlanCopyWith(
          LessonPlan value, $Res Function(LessonPlan) then) =
      _$LessonPlanCopyWithImpl<$Res, LessonPlan>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String subject,
      @HiveField(3) DateTime date,
      @HiveField(4) String startTime,
      @HiveField(5) String endTime,
      @HiveField(6) String objective,
      @HiveField(7) List<String> materials,
      @HiveField(8) String activities,
      @HiveField(9) String? assessment,
      @HiveField(10) String? notes,
      @HiveField(11) bool isCompleted,
      @HiveField(12) DateTime createdAt});
}

/// @nodoc
class _$LessonPlanCopyWithImpl<$Res, $Val extends LessonPlan>
    implements $LessonPlanCopyWith<$Res> {
  _$LessonPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subject = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? objective = null,
    Object? materials = null,
    Object? activities = null,
    Object? assessment = freezed,
    Object? notes = freezed,
    Object? isCompleted = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      objective: null == objective
          ? _value.objective
          : objective // ignore: cast_nullable_to_non_nullable
              as String,
      materials: null == materials
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as List<String>,
      activities: null == activities
          ? _value.activities
          : activities // ignore: cast_nullable_to_non_nullable
              as String,
      assessment: freezed == assessment
          ? _value.assessment
          : assessment // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LessonPlanImplCopyWith<$Res>
    implements $LessonPlanCopyWith<$Res> {
  factory _$$LessonPlanImplCopyWith(
          _$LessonPlanImpl value, $Res Function(_$LessonPlanImpl) then) =
      __$$LessonPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String subject,
      @HiveField(3) DateTime date,
      @HiveField(4) String startTime,
      @HiveField(5) String endTime,
      @HiveField(6) String objective,
      @HiveField(7) List<String> materials,
      @HiveField(8) String activities,
      @HiveField(9) String? assessment,
      @HiveField(10) String? notes,
      @HiveField(11) bool isCompleted,
      @HiveField(12) DateTime createdAt});
}

/// @nodoc
class __$$LessonPlanImplCopyWithImpl<$Res>
    extends _$LessonPlanCopyWithImpl<$Res, _$LessonPlanImpl>
    implements _$$LessonPlanImplCopyWith<$Res> {
  __$$LessonPlanImplCopyWithImpl(
      _$LessonPlanImpl _value, $Res Function(_$LessonPlanImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subject = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? objective = null,
    Object? materials = null,
    Object? activities = null,
    Object? assessment = freezed,
    Object? notes = freezed,
    Object? isCompleted = null,
    Object? createdAt = null,
  }) {
    return _then(_$LessonPlanImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      objective: null == objective
          ? _value.objective
          : objective // ignore: cast_nullable_to_non_nullable
              as String,
      materials: null == materials
          ? _value._materials
          : materials // ignore: cast_nullable_to_non_nullable
              as List<String>,
      activities: null == activities
          ? _value.activities
          : activities // ignore: cast_nullable_to_non_nullable
              as String,
      assessment: freezed == assessment
          ? _value.assessment
          : assessment // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonPlanImpl implements _LessonPlan {
  const _$LessonPlanImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) required this.subject,
      @HiveField(3) required this.date,
      @HiveField(4) required this.startTime,
      @HiveField(5) required this.endTime,
      @HiveField(6) required this.objective,
      @HiveField(7) final List<String> materials = const [],
      @HiveField(8) required this.activities,
      @HiveField(9) this.assessment,
      @HiveField(10) this.notes,
      @HiveField(11) this.isCompleted = false,
      @HiveField(12) required this.createdAt})
      : _materials = materials;

  factory _$LessonPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonPlanImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String title;
  @override
  @HiveField(2)
  final String subject;
  @override
  @HiveField(3)
  final DateTime date;
  @override
  @HiveField(4)
  final String startTime;
  @override
  @HiveField(5)
  final String endTime;
  @override
  @HiveField(6)
  final String objective;
  final List<String> _materials;
  @override
  @JsonKey()
  @HiveField(7)
  List<String> get materials {
    if (_materials is EqualUnmodifiableListView) return _materials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_materials);
  }

  @override
  @HiveField(8)
  final String activities;
  @override
  @HiveField(9)
  final String? assessment;
  @override
  @HiveField(10)
  final String? notes;
  @override
  @JsonKey()
  @HiveField(11)
  final bool isCompleted;
  @override
  @HiveField(12)
  final DateTime createdAt;

  @override
  String toString() {
    return 'LessonPlan(id: $id, title: $title, subject: $subject, date: $date, startTime: $startTime, endTime: $endTime, objective: $objective, materials: $materials, activities: $activities, assessment: $assessment, notes: $notes, isCompleted: $isCompleted, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.objective, objective) ||
                other.objective == objective) &&
            const DeepCollectionEquality()
                .equals(other._materials, _materials) &&
            (identical(other.activities, activities) ||
                other.activities == activities) &&
            (identical(other.assessment, assessment) ||
                other.assessment == assessment) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      subject,
      date,
      startTime,
      endTime,
      objective,
      const DeepCollectionEquality().hash(_materials),
      activities,
      assessment,
      notes,
      isCompleted,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonPlanImplCopyWith<_$LessonPlanImpl> get copyWith =>
      __$$LessonPlanImplCopyWithImpl<_$LessonPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonPlanImplToJson(
      this,
    );
  }
}

abstract class _LessonPlan implements LessonPlan {
  const factory _LessonPlan(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String title,
      @HiveField(2) required final String subject,
      @HiveField(3) required final DateTime date,
      @HiveField(4) required final String startTime,
      @HiveField(5) required final String endTime,
      @HiveField(6) required final String objective,
      @HiveField(7) final List<String> materials,
      @HiveField(8) required final String activities,
      @HiveField(9) final String? assessment,
      @HiveField(10) final String? notes,
      @HiveField(11) final bool isCompleted,
      @HiveField(12) required final DateTime createdAt}) = _$LessonPlanImpl;

  factory _LessonPlan.fromJson(Map<String, dynamic> json) =
      _$LessonPlanImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get title;
  @override
  @HiveField(2)
  String get subject;
  @override
  @HiveField(3)
  DateTime get date;
  @override
  @HiveField(4)
  String get startTime;
  @override
  @HiveField(5)
  String get endTime;
  @override
  @HiveField(6)
  String get objective;
  @override
  @HiveField(7)
  List<String> get materials;
  @override
  @HiveField(8)
  String get activities;
  @override
  @HiveField(9)
  String? get assessment;
  @override
  @HiveField(10)
  String? get notes;
  @override
  @HiveField(11)
  bool get isCompleted;
  @override
  @HiveField(12)
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$LessonPlanImplCopyWith<_$LessonPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
