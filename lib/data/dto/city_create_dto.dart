import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_create_dto.freezed.dart';
part 'city_create_dto.g.dart';

@freezed
class CityCreateDto with _$CityCreateDto {
  const factory CityCreateDto({
    required String name,
  }) = _CityCreateDto;

  factory CityCreateDto.fromJson(Map<String, dynamic> json) =>
      _$CityCreateDtoFromJson(json);
}
