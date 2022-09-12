// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'upvote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Upvote _$UpvoteFromJson(Map<String, dynamic> json) {
  return _Upvote.fromJson(json);
}

/// @nodoc
mixin _$Upvote {
  String get uid => throw _privateConstructorUsedError;
  String get userUid => throw _privateConstructorUsedError;
  String get postUid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpvoteCopyWith<Upvote> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpvoteCopyWith<$Res> {
  factory $UpvoteCopyWith(Upvote value, $Res Function(Upvote) then) =
      _$UpvoteCopyWithImpl<$Res>;
  $Res call({String uid, String userUid, String postUid});
}

/// @nodoc
class _$UpvoteCopyWithImpl<$Res> implements $UpvoteCopyWith<$Res> {
  _$UpvoteCopyWithImpl(this._value, this._then);

  final Upvote _value;
  // ignore: unused_field
  final $Res Function(Upvote) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? userUid = freezed,
    Object? postUid = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      userUid: userUid == freezed
          ? _value.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
              as String,
      postUid: postUid == freezed
          ? _value.postUid
          : postUid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_UpvoteCopyWith<$Res> implements $UpvoteCopyWith<$Res> {
  factory _$$_UpvoteCopyWith(_$_Upvote value, $Res Function(_$_Upvote) then) =
      __$$_UpvoteCopyWithImpl<$Res>;
  @override
  $Res call({String uid, String userUid, String postUid});
}

/// @nodoc
class __$$_UpvoteCopyWithImpl<$Res> extends _$UpvoteCopyWithImpl<$Res>
    implements _$$_UpvoteCopyWith<$Res> {
  __$$_UpvoteCopyWithImpl(_$_Upvote _value, $Res Function(_$_Upvote) _then)
      : super(_value, (v) => _then(v as _$_Upvote));

  @override
  _$_Upvote get _value => super._value as _$_Upvote;

  @override
  $Res call({
    Object? uid = freezed,
    Object? userUid = freezed,
    Object? postUid = freezed,
  }) {
    return _then(_$_Upvote(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      userUid: userUid == freezed
          ? _value.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
              as String,
      postUid: postUid == freezed
          ? _value.postUid
          : postUid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Upvote implements _Upvote {
  _$_Upvote({required this.uid, required this.userUid, required this.postUid});

  factory _$_Upvote.fromJson(Map<String, dynamic> json) =>
      _$$_UpvoteFromJson(json);

  @override
  final String uid;
  @override
  final String userUid;
  @override
  final String postUid;

  @override
  String toString() {
    return 'Upvote(uid: $uid, userUid: $userUid, postUid: $postUid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Upvote &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.userUid, userUid) &&
            const DeepCollectionEquality().equals(other.postUid, postUid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(userUid),
      const DeepCollectionEquality().hash(postUid));

  @JsonKey(ignore: true)
  @override
  _$$_UpvoteCopyWith<_$_Upvote> get copyWith =>
      __$$_UpvoteCopyWithImpl<_$_Upvote>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UpvoteToJson(
      this,
    );
  }
}

abstract class _Upvote implements Upvote {
  factory _Upvote(
      {required final String uid,
      required final String userUid,
      required final String postUid}) = _$_Upvote;

  factory _Upvote.fromJson(Map<String, dynamic> json) = _$_Upvote.fromJson;

  @override
  String get uid;
  @override
  String get userUid;
  @override
  String get postUid;
  @override
  @JsonKey(ignore: true)
  _$$_UpvoteCopyWith<_$_Upvote> get copyWith =>
      throw _privateConstructorUsedError;
}
