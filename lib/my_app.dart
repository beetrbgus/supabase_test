import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_test/data/controller/city_controller.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _nameInputController = TextEditingController();
  @override
  void dispose() {
    _nameInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cityProvider);
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 4,
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        controller: _nameInputController,
                        validator: (value) {
                          if (value == null || value!.isEmpty)
                            return "도시 이름을 입력하세요";
                          return null;
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        final String name = _nameInputController.text;
                        if (name.isNotEmpty)
                          ref.watch(cityProvider.notifier).addCity(name);
                        else
                          print("빈 값임");
                      },
                      child: Text("전송"),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: state.when(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
