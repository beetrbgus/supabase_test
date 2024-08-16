import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_test/data/domain/city.dart';
import 'package:supabase_test/data/repository/city_repository.dart';

final cityProvider =
    AsyncNotifierProvider<CityController, List<City>>(() => CityController());

class CityController extends AsyncNotifier<List<City>> {
  late final CityRepository _cityRepository;
  @override
  FutureOr<List<City>> build() {
    _cityRepository = ref.watch(cityRepositoryProvider);
    _fetchCityList();
    return [];
  }

  void _fetchCityList() async {
    state = const AsyncLoading();
    state = AsyncData(await _cityRepository.getCityInfo());
  }

  void addCity(String cityName) {
    _cityRepository.addCity(cityName);
    _fetchCityList();
  }
}
