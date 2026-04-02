// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'iep_goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IEPGoal _$IEPGoalFromJson(Map<String, dynamic> json) {
  return _IEPGoal.fromJson(json);
}

/// @nodoc
mixin _$IEPGoal {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get studentId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get goalText => throw _privateConstructorUsedError;
  @HiveField(3)
  String get category => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get targetDate => throw _privateConstructorUsedError;
  @HiveField(5)
  double get progressPercent => throw _privateConstructorUsedError;
  @HiveField(6)
  List<String> get accommodations => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get notes => throw _privateConstructorUsedError;
  @HiveField(8)
  GoalStatus get status => throw _privateConstructorUsedError;
  @HiveField(9)
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IEPGoalCopyWith<IEPGoal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IEPGoalCopyWith<$Res> {
  factory $IEPGoalCopyWith(IEPGoal value, $Res Function(IEPGoal) then) =
      _$IEPGoalCopyWithImpl<$Res, IEPGoal>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String studentId,
      @HiveField(2) String goalText,
      @HiveField(3) String category,
      @HiveField(4) DateTime targetDate,
      @HiveField(5) double progressPercent,
      @HiveField(6) List<String> accommodations,
      @HiveField(7) String? notes,
      @HiveField(8) GoalStatus status,
      @HiveField(9) DateTime createdAt});
}

/// @nodoc
class _$IEPGoalCopyWithImpl<$Res, $Val extends IEPGoal>
    implements $IEPGoalCopyWith<$Res> {
  _$IEPGoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? goalText = null,
    Object? category = null,
    Object? targetDate = null,
    Object? progressPercent = null,
    Object? accommodations = null,
    Object? notes = freezed,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      goalText: null == goalText
          ? _value.goalText
          : goalText // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      targetDate: null == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      progressPercent: null == progressPercent
          ? _value.progressPercent
          : progressPercent // ignore: cast_nullable_to_non_nullable
              as double,
      accommodations: null == accommodations
          ? _value.accommodations
          : accommodations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GoalStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IEPGoalImplCopyWith<$Res> implements $IEPGoalCopyWith<$Res> {
  factory _$$IEPGoalImplCopyWith(
          _$IEPGoalImpl value, $Res Function(_$IEPGoalImpl) then) =
      __$$IEPGoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String studentId,
      @HiveField(2) String goalText,
      @HiveField(3) String category,
      @HiveField(4) DateTime targetDate,
      @HiveField(5) double progressPercent,
      @HiveField(6) List<String> accommodations,
      @HiveField(7) String? notes,
      @HiveField(8) GoalStatus status,
      @HiveField(9) DateTime createdAt});
}

/// @nodoc
class __$$IEPGoalImplCopyWithImpl<$Res>
    extends _$IEPGoalCopyWithImpl<$Res, _$IEPGoalImpl>
    implements _$$IEPGoalImplCopyWith<$Res> {
  __$$IEPGoalImplCopyWithImpl(
      _$IEPGoalImpl _value, $Res Function(_$IEPGoalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? goalText = null,
    Object? category = null,
    Object? targetDate = null,
    Object? progressPercent = null,
    Object? accommodations = null,
    Object? notes = freezed,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(_$IEPGoalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      goalText: null == goalText
          ? _value.goalText
          : goalText // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      targetDate: null == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      progressPercent: null == progressPercent
          ? _value.progressPercent
          : progressPercent // ignore: cast_nullable_to_non_nullable
              as double,
      accommodations: null == accommodations
          ? _value._accommodations
          : accommodations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GoalStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IEPGoalImpl implements _IEPGoal {
  const _$IEPGoalImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.studentId,
      @HiveField(2) required this.goalText,
      @HiveField(3) required this.category,
      @HiveField(4) required this.targetDate,
      @HiveField(5) this.progressPercent = 0.0,
      @HiveField(6) final List<String> accommodations = const [],
      @HiveField(7) this.notes,
      @HiveField(8) this.status = GoalStatus.active,
      @HiveField(9) required this.createdAt})
      : _accommodations = accommodations;

  factory _$IEPGoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$IEPGoalImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String studentId;
  @override
  @HiveField(2)
  final String goalText;
  @override
  @HiveField(3)
  final String category;
  @override
  @HiveField(4)
  final DateTime targetDate;
  @override
  @JsonKey()
  @HiveField(5)
  final double progressPercent;
  final List<String> _accommodations;
  @override
  @JsonKey()
  @HiveField(6)
  List<String> get accommodations {
    if (_accommodations is EqualUnmodifiableListView) return _accommodations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accommodations);
  }

  @override
  @HiveField(7)
  final String? notes;
  @override
  @JsonKey()
  @HiveField(8)
  final GoalStatus status;
  @override
  @HiveField(9)
  final DateTime createdAt;

  @override
  String toString() {
    return 'IEPGoal(id: $id, studentId: $studentId, goalText: $goalText, category: $category, targetDate: $targetDate, progressPercent: $progressPercent, accommodations: $accommodations, notes: $notes, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IEPGoalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.goalText, goalText) ||
                other.goalText == goalText) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate) &&
            (identical(other.progressPercent, progressPercent) ||
                other.progressPercent == progressPercent) &&
            const DeepCollectionEquality()
                .equals(other._accommodations, _accommodations) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      studentId,
      goalText,
      category,
      targetDate,
      progressPercent,
      const DeepCollectionEquality().hash(_accommodations),
      notes,
      status,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IEPGoalImplCopyWith<_$IEPGoalImpl> get copyWith =>
      __$$IEPGoalImplCopyWithImpl<_$IEPGoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IEPGoalImplToJson(
      this,
    );
  }
}

abstract class _IEPGoal implements IEPGoal {
  const factory _IEPGoal(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String studentId,
      @HiveField(2) required final String goalText,
      @HiveField(3) required final String category,
      @HiveField(4) required final DateTime targetDate,
      @HiveField(5) final double progressPercent,
      @HiveField(6) final List<String> accommodations,
      @HiveField(7) final String? notes,
      @HiveField(8) final GoalStatus status,
      @HiveField(9) required final DateTime createdAt}) = _$IEPGoalImpl;

  factory _IEPGoal.fromJson(Map<String, dynamic> json) = _$IEPGoalImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get studentId;
  @override
  @HiveField(2)
  String get goalText;
  @override
  @HiveField(3)
  String get category;
  @override
  @HiveField(4)
  DateTime get targetDate;
  @override
  @HiveField(5)
  double get progressPercent;
  @override
  @HiveField(6)
  List<String> get accommodations;
  @override
  @HiveField(7)
  String? get notes;
  @override
  @HiveField(8)
  GoalStatus get status;
  @override
  @HiveField(9)
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$IEPGoalImplCopyWith<_$IEPGoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IEPProgressNote _$IEPProgressNoteFromJson(Map<String, dynamic> json) {
  return _IEPProgressNote.fromJson(json);
}

/// @nodoc
mixin _$IEPProgressNote {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get goalId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get note => throw _privateConstructorUsedError;
  @HiveField(3)
  double get progressPercent => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get recordedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IEPProgressNoteCopyWith<IEPProgressNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IEPProgressNoteCopyWith<$Res> {
  factory $IEPProgressNoteCopyWith(
          IEPProgressNote value, $Res Function(IEPProgressNote) then) =
      _$IEPProgressNoteCopyWithImpl<$Res, IEPProgressNote>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String goalId,
      @HiveField(2) String note,
      @HiveField(3) double progressPercent,
      @HiveField(4) DateTime recordedAt});
}

/// @nodoc
class _$IEPProgressNoteCopyWithImpl<$Res, $Val extends IEPProgressNote>
    implements $IEPProgressNoteCopyWith<$Res> {
  _$IEPProgressNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? goalId = null,
    Object? note = null,
    Object? progressPercent = null,
    Object? recordedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      progressPercent: null == progressPercent
          ? _value.progressPercent
          : progressPercent // ignore: cast_nullable_to_non_nullable
              as double,
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IEPProgressNoteImplCopyWith<$Res>
    implements $IEPProgressNoteCopyWith<$Res> {
  factory _$$IEPProgressNoteImplCopyWith(_$IEPProgressNoteImpl value,
          $Res Function(_$IEPProgressNoteImpl) then) =
      __$$IEPProgressNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String goalId,
      @HiveField(2) String note,
      @HiveField(3) double progressPercent,
      @HiveField(4) DateTime recordedAt});
}

/// @nodoc
class __$$IEPProgressNoteImplCopyWithImpl<$Res>
    extends _$IEPProgressNoteCopyWithImpl<$Res, _$IEPProgressNoteImpl>
    implements _$$IEPProgressNoteImplCopyWith<$Res> {
  __$$IEPProgressNoteImplCopyWithImpl(
      _$IEPProgressNoteImpl _value, $Res Function(_$IEPProgressNoteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? goalId = null,
    Object? note = null,
    Object? progressPercent = null,
    Object? recordedAt = null,
  }) {
    return _then(_$IEPProgressNoteImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      progressPercent: null == progressPercent
          ? _value.progressPercent
          : progressPercent // ignore: cast_nullable_to_non_nullable
              as double,
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IEPProgressNoteImpl implements _IEPProgressNote {
  const _$IEPProgressNoteImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.goalId,
      @HiveField(2) required this.note,
      @HiveField(3) required this.progressPercent,
      @HiveField(4) required this.recordedAt});

  factory _$IEPProgressNoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$IEPProgressNoteImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String goalId;
  @override
  @HiveField(2)
  final String note;
  @override
  @HiveField(3)
  final double progressPercent;
  @override
  @HiveField(4)
  final DateTime recordedAt;

  @override
  String toString() {
    return 'IEPProgressNote(id: $id, goalId: $goalId, note: $note, progressPercent: $progressPercent, recordedAt: $recordedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IEPProgressNoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.goalId, goalId) || other.goalId == goalId) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.progressPercent, progressPercent) ||
                other.progressPercent == progressPercent) &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, goalId, note, progressPercent, recordedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IEPProgressNoteImplCopyWith<_$IEPProgressNoteImpl> get copyWith =>
      __$$IEPProgressNoteImplCopyWithImpl<_$IEPProgressNoteImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IEPProgressNoteImplToJson(
      this,
    );
  }
}

abstract class _IEPProgressNote implements IEPProgressNote {
  const factory _IEPProgressNote(
          {@HiveField(0) required final String id,
          @HiveField(1) required final String goalId,
          @HiveField(2) required final String note,
          @HiveField(3) required final double progressPercent,
          @HiveField(4) required final DateTime recordedAt}) =
      _$IEPProgressNoteImpl;

  factory _IEPProgressNote.fromJson(Map<String, dynamic> json) =
      _$IEPProgressNoteImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get goalId;
  @override
  @HiveField(2)
  String get note;
  @override
  @HiveField(3)
  double get progressPercent;
  @override
  @HiveField(4)
  DateTime get recordedAt;
  @override
  @JsonKey(ignore: true)
  _$$IEPProgressNoteImplCopyWith<_$IEPProgressNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
