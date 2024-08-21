// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AudioDTO _$AudioDTOFromJson(Map<String, dynamic> json) {
  return _AudioDTO.fromJson(json);
}

/// @nodoc
mixin _$AudioDTO {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get theme => throw _privateConstructorUsedError;
  @JsonKey(name: 'audio_url')
  String get audioUrl => throw _privateConstructorUsedError;

  /// Serializes this AudioDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AudioDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioDTOCopyWith<AudioDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioDTOCopyWith<$Res> {
  factory $AudioDTOCopyWith(AudioDTO value, $Res Function(AudioDTO) then) =
      _$AudioDTOCopyWithImpl<$Res, AudioDTO>;
  @useResult
  $Res call(
      {int id,
      String name,
      String theme,
      @JsonKey(name: 'audio_url') String audioUrl});
}

/// @nodoc
class _$AudioDTOCopyWithImpl<$Res, $Val extends AudioDTO>
    implements $AudioDTOCopyWith<$Res> {
  _$AudioDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? theme = null,
    Object? audioUrl = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      audioUrl: null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioDTOImplCopyWith<$Res>
    implements $AudioDTOCopyWith<$Res> {
  factory _$$AudioDTOImplCopyWith(
          _$AudioDTOImpl value, $Res Function(_$AudioDTOImpl) then) =
      __$$AudioDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String theme,
      @JsonKey(name: 'audio_url') String audioUrl});
}

/// @nodoc
class __$$AudioDTOImplCopyWithImpl<$Res>
    extends _$AudioDTOCopyWithImpl<$Res, _$AudioDTOImpl>
    implements _$$AudioDTOImplCopyWith<$Res> {
  __$$AudioDTOImplCopyWithImpl(
      _$AudioDTOImpl _value, $Res Function(_$AudioDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? theme = null,
    Object? audioUrl = null,
  }) {
    return _then(_$AudioDTOImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      audioUrl: null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AudioDTOImpl implements _AudioDTO {
  const _$AudioDTOImpl(
      {required this.id,
      required this.name,
      required this.theme,
      @JsonKey(name: 'audio_url') required this.audioUrl});

  factory _$AudioDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$AudioDTOImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String theme;
  @override
  @JsonKey(name: 'audio_url')
  final String audioUrl;

  @override
  String toString() {
    return 'AudioDTO(id: $id, name: $name, theme: $theme, audioUrl: $audioUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, theme, audioUrl);

  /// Create a copy of AudioDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioDTOImplCopyWith<_$AudioDTOImpl> get copyWith =>
      __$$AudioDTOImplCopyWithImpl<_$AudioDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AudioDTOImplToJson(
      this,
    );
  }
}

abstract class _AudioDTO implements AudioDTO {
  const factory _AudioDTO(
          {required final int id,
          required final String name,
          required final String theme,
          @JsonKey(name: 'audio_url') required final String audioUrl}) =
      _$AudioDTOImpl;

  factory _AudioDTO.fromJson(Map<String, dynamic> json) =
      _$AudioDTOImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get theme;
  @override
  @JsonKey(name: 'audio_url')
  String get audioUrl;

  /// Create a copy of AudioDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioDTOImplCopyWith<_$AudioDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
