// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      postID: json['postID'] as String,
      foodName: json['foodName'] as String,
      opUid: json['opUid'] as String,
      upvotes: json['upvotes'] as int,
      date: json['date'] as String,
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'postID': instance.postID,
      'foodName': instance.foodName,
      'opUid': instance.opUid,
      'upvotes': instance.upvotes,
      'date': instance.date,
    };
