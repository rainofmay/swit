// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDTOImpl _$$UserDTOImplFromJson(Map<String, dynamic> json) =>
    _$UserDTOImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      followerCount: (json['follower_count'] as num?)?.toInt(),
      followingCount: (json['following_count'] as num?)?.toInt(),
      introduction: json['introduction'] as String?,
      profileUrl: json['profile_url'] as String,
    );

Map<String, dynamic> _$$UserDTOImplToJson(_$UserDTOImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'username': instance.username,
      'follower_count': instance.followerCount,
      'following_count': instance.followingCount,
      'introduction': instance.introduction,
      'profile_url': instance.profileUrl,
    };
