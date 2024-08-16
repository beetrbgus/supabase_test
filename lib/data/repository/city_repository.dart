import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_test/data/datasource/city_datasource.dart';
import 'package:supabase_test/data/domain/city.dart';
import 'package:supabase_test/data/dto/city_create_dto.dart';

final cityRepositoryProvider = Provider(
  (ref) => CityRepository(ref.read(cityDataSourceProvider)),
);

class CityRepository {
  const CityRepository(this._cityDatasource);
  final CityDatasource _cityDatasource;

  Future<List<City>> getCityInfo() async {
    try {
      return _cityDatasource.fetchCityInfo().then(
        (cityJsonList) {
          return cityJsonList
              .map((cityJson) => City.fromJson(cityJson))
              .toList();
        },
      );
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> addCity(String cityName) async {
    try {
      CityCreateDto cityCreateDto = CityCreateDto(name: cityName);
      await _cityDatasource.addCity(cityCreateDto);
    } catch (e) {
      print(e);
    }
  }
}
