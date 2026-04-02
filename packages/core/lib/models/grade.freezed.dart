// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grade.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Assignment _$AssignmentFromJson(Map<String, dynamic> json) {
  return _Assignment.fromJson(json);
}

/// @nodoc
mixin _$Assignment {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  String get subject => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime get dueDate => throw _privateConstructorUsedError;
  @HiveField(4)
  double get totalPoints => throw _privateConstructorUsedError;
  @HiveField(5)
  AssignmentCategory get category => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get description => throw _privateConstructorUsedError;
  @HiveField(7)
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssignmentCopyWith<Assignment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssignmentCopyWith<$Res> {
  factory $AssignmentCopyWith(
          Assignment value, $Res Function(Assignment) then) =
      _$AssignmentCopyWithImpl<$Res, Assignment>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String subject,
      @HiveField(3) DateTime dueDate,
      @HiveField(4) double totalPoints,
      @HiveField(5) AssignmentCategory category,
      @HiveField(6) String? description,
      @HiveField(7) DateTime createdAt});
}

/// @nodoc
class _$AssignmentCopyWithImpl<$Res, $Val extends Assignment>
    implements $AssignmentCopyWith<$Res> {
  _$AssignmentCopyWithImpl(this._value, this._then);

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
    Object? dueDate = null,
    Object? totalPoints = null,
    Object? category = null,
    Object? description = freezed,
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
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as AssignmentCategory,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssignmentImplCopyWith<$Res>
    implements $AssignmentCopyWith<$Res> {
  factory _$$AssignmentImplCopyWith(
          _$AssignmentImpl value, $Res Function(_$AssignmentImpl) then) =
      __$$AssignmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String subject,
      @HiveField(3) DateTime dueDate,
      @HiveField(4) double totalPoints,
      @HiveField(5) AssignmentCategory category,
      @HiveField(6) String? description,
      @HiveField(7) DateTime createdAt});
}

/// @nodoc
class __$$AssignmentImplCopyWithImpl<$Res>
    extends _$AssignmentCopyWithImpl<$Res, _$AssignmentImpl>
    implements _$$AssignmentImplCopyWith<$Res> {
  __$$AssignmentImplCopyWithImpl(
      _$AssignmentImpl _value, $Res Function(_$AssignmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subject = null,
    Object? dueDate = null,
    Object? totalPoints = null,
    Object? category = null,
    Object? description = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$AssignmentImpl(
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
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as AssignmentCategory,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssignmentImpl implements _Assignment {
  const _$AssignmentImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) required this.subject,
      @HiveField(3) required this.dueDate,
      @HiveField(4) required this.totalPoints,
      @HiveField(5) required this.category,
      @HiveField(6) this.description,
      @HiveField(7) required this.createdAt});

  factory _$AssignmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssignmentImplFromJson(json);

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
  final DateTime dueDate;
  @override
  @HiveField(4)
  final double totalPoints;
  @override
  @HiveField(5)
  final AssignmentCategory category;
  @override
  @HiveField(6)
  final String? description;
  @override
  @HiveField(7)
  final DateTime createdAt;

  @override
  String toString() {
    return 'Assignment(id: $id, title: $title, subject: $subject, dueDate: $dueDate, totalPoints: $totalPoints, category: $category, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssignmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, subject, dueDate,
      totalPoints, category, description, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssignmentImplCopyWith<_$AssignmentImpl> get copyWith =>
      __$$AssignmentImplCopyWithImpl<_$AssignmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssignmentImplToJson(
      this,
    );
  }
}

abstract class _Assignment implements Assignment {
  const factory _Assignment(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String title,
      @HiveField(2) required final String subject,
      @HiveField(3) required final DateTime dueDate,
      @HiveField(4) required final double totalPoints,
      @HiveField(5) required final AssignmentCategory category,
      @HiveField(6) final String? description,
      @HiveField(7) required final DateTime createdAt}) = _$AssignmentImpl;

  factory _Assignment.fromJson(Map<String, dynamic> json) =
      _$AssignmentImpl.fromJson;

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
  DateTime get dueDate;
  @override
  @HiveField(4)
  double get totalPoints;
  @override
  @HiveField(5)
  AssignmentCategory get category;
  @override
  @HiveField(6)
  String? get description;
  @override
  @HiveField(7)
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AssignmentImplCopyWith<_$AssignmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GradeEntry _$GradeEntryFromJson(Map<String, dynamic> json) {
  return _GradeEntry.fromJson(json);
}

/// @nodoc
mixin _$GradeEntry {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get studentId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get assignmentId => throw _privateConstructorUsedError;
  @HiveField(3)
  double get pointsEarned => throw _privateConstructorUsedError;
  @HiveField(4)
  bool get isExcused => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get notes => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime get gradedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GradeEntryCopyWith<GradeEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GradeEntryCopyWith<$Res> {
  factory $GradeEntryCopyWith(
          GradeEntry value, $Res Function(GradeEntry) then) =
      _$GradeEntryCopyWithImpl<$Res, GradeEntry>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String studentId,
      @HiveField(2) String assignmentId,
      @HiveField(3) double pointsEarned,
      @HiveField(4) bool isExcused,
      @HiveField(5) String? notes,
      @HiveField(6) DateTime gradedAt});
}

/// @nodoc
class _$GradeEntryCopyWithImpl<$Res, $Val extends GradeEntry>
    implements $GradeEntryCopyWith<$Res> {
  _$GradeEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? assignmentId = null,
    Object? pointsEarned = null,
    Object? isExcused = null,
    Object? notes = freezed,
    Object? gradedAt = null,
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
      assignmentId: null == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      pointsEarned: null == pointsEarned
          ? _value.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as double,
      isExcused: null == isExcused
          ? _value.isExcused
          : isExcused // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      gradedAt: null == gradedAt
          ? _value.gradedAt
          : gradedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GradeEntryImplCopyWith<$Res>
    implements $GradeEntryCopyWith<$Res> {
  factory _$$GradeEntryImplCopyWith(
          _$GradeEntryImpl value, $Res Function(_$GradeEntryImpl) then) =
      __$$GradeEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String studentId,
      @HiveField(2) String assignmentId,
      @HiveField(3) double pointsEarned,
      @HiveField(4) bool isExcused,
      @HiveField(5) String? notes,
      @HiveField(6) DateTime gradedAt});
}

/// @nodoc
class __$$GradeEntryImplCopyWithImpl<$Res>
    extends _$GradeEntryCopyWithImpl<$Res, _$GradeEntryImpl>
    implements _$$GradeEntryImplCopyWith<$Res> {
  __$$GradeEntryImplCopyWithImpl(
      _$GradeEntryImpl _value, $Res Function(_$GradeEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? assignmentId = null,
    Object? pointsEarned = null,
    Object? isExcused = null,
    Object? notes = freezed,
    Object? gradedAt = null,
  }) {
    return _then(_$GradeEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      assignmentId: null == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      pointsEarned: null == pointsEarned
          ? _value.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as double,
      isExcused: null == isExcused
          ? _value.isExcused
          : isExcused // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      gradedAt: null == gradedAt
          ? _value.gradedAt
          : gradedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GradeEntryImpl implements _GradeEntry {
  const _$GradeEntryImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.studentId,
      @HiveField(2) required this.assignmentId,
      @HiveField(3) required this.pointsEarned,
      @HiveField(4) this.isExcused = false,
      @HiveField(5) this.notes,
      @HiveField(6) required this.gradedAt});

  factory _$GradeEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$GradeEntryImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String studentId;
  @override
  @HiveField(2)
  final String assignmentId;
  @override
  @HiveField(3)
  final double pointsEarned;
  @override
  @JsonKey()
  @HiveField(4)
  final bool isExcused;
  @override
  @HiveField(5)
  final String? notes;
  @override
  @HiveField(6)
  final DateTime gradedAt;

  @override
  String toString() {
    return 'GradeEntry(id: $id, studentId: $studentId, assignmentId: $assignmentId, pointsEarned: $pointsEarned, isExcused: $isExcused, notes: $notes, gradedAt: $gradedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GradeEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.assignmentId, assignmentId) ||
                other.assignmentId == assignmentId) &&
            (identical(other.pointsEarned, pointsEarned) ||
                other.pointsEarned == pointsEarned) &&
            (identical(other.isExcused, isExcused) ||
                other.isExcused == isExcused) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.gradedAt, gradedAt) ||
                other.gradedAt == gradedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, studentId, assignmentId,
      pointsEarned, isExcused, notes, gradedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GradeEntryImplCopyWith<_$GradeEntryImpl> get copyWith =>
      __$$GradeEntryImplCopyWithImpl<_$GradeEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GradeEntryImplToJson(
      this,
    );
  }
}

abstract class _GradeEntry implements GradeEntry {
  const factory _GradeEntry(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String studentId,
      @HiveField(2) required final String assignmentId,
      @HiveField(3) required final double pointsEarned,
      @HiveField(4) final bool isExcused,
      @HiveField(5) final String? notes,
      @HiveField(6) required final DateTime gradedAt}) = _$GradeEntryImpl;

  factory _GradeEntry.fromJson(Map<String, dynamic> json) =
      _$GradeEntryImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get studentId;
  @override
  @HiveField(2)
  String get assignmentId;
  @override
  @HiveField(3)
  double get pointsEarned;
  @override
  @HiveField(4)
  bool get isExcused;
  @override
  @HiveField(5)
  String? get notes;
  @override
  @HiveField(6)
  DateTime get gradedAt;
  @override
  @JsonKey(ignore: true)
  _$$GradeEntryImplCopyWith<_$GradeEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
