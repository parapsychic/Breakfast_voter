import 'package:freezed_annotation/freezed_annotation.dart';

part 'upvote.freezed.dart';
part 'upvote.g.dart';

@freezed
class Upvote with _$Upvote {
  factory Upvote({
    required String uid,
    required String userUid,
    required String postUid,
  }) = _Upvote;

  factory Upvote.fromJson(Map<String, dynamic> json) => _$UpvoteFromJson(json);
}
