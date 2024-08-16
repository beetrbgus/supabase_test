import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_test/data/datasource/supabase_db_name.dart';
import 'package:supabase_test/data/dto/city_create_dto.dart';

final cityDataSourceProvider = Provider((ref) => CityDatasource());

class CityDatasource {
  CityDatasource();
  SupabaseClient supabaseClient = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchCityInfo() async {
    return supabaseClient.from(SupabaseDBName.counties.dbName).select().then(
      (cityJsonMap) {
        return cityJsonMap;
      },
    );
  }

  Future<void> addCity(CityCreateDto cityCreateDto) async {
    await supabaseClient
        .from(SupabaseDBName.counties.dbName)
        .insert(cityCreateDto.toJson());
  }
}
