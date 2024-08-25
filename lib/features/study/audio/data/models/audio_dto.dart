import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_dto.freezed.dart';
part 'audio_dto.g.dart';

@freezed
class AudioDTO with _$AudioDTO {
  const factory AudioDTO({
    required int id,
    required String name,
    required String theme,
    @JsonKey(name: 'audio_url') required String audioUrl,
  }) = _AudioDTO;

  factory AudioDTO.fromJson(Map<String, dynamic> json) => _$AudioDTOFromJson(json);
}