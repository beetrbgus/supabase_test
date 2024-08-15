import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_test/data/controller/city_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cityProvider);

    return Scaffold(
      body: state.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: ((context, index) {
              final city = data[index];
              return ListTile(
                title: Text(city.name),
              );
            }),
          );
        },
        error: (error, stackTrace) => Container(),
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
