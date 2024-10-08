import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_test/cloudflare/config/cloudflare_init.dart';
import 'package:supabase_test/supabase/my_video.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  var SUPABASE_URL = dotenv.get("SUPABASE_URL");
  var ANON_KEY = dotenv.get("ANON_KEY");
  var BUCKET_NAME = dotenv.get("BUCKET_NAME");

  await Supabase.initialize(
    url: SUPABASE_URL,
    anonKey: ANON_KEY,
  );
  CloudflareInit.init();

  final a =
      await Supabase.instance.client.storage.from(BUCKET_NAME).list().then(
    (value) {
      print("list");
      print(value);
      for (var file in value) print("file name is ${file.name}");
    },
  );

  final storageResponse = await Supabase.instance.client.storage
      .from(BUCKET_NAME)
      .download("public/cat.jpeg")
      .then(
    (value) {
      print("value.length is ${value.length}");
    },
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Countries',
      home: MyVideo(),
    );
  }
}
