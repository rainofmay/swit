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
      introduction: json['introduction'] as String?,
      profileUrl: json['profile_url'] as String,
    );

Map<String, dynamic> _$$UserDTOImplToJson(_$UserDTOImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'username': instance.username,
      'introduction': instance.introduction,
      'profile_url': instance.profileUrl,
    };
