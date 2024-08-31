import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_test/supabase/file_mime_type.dart';
import 'package:supabase_test/supabase/file_size_limit.dart';

class CreateBucket extends ConsumerWidget {
  const CreateBucket({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Supabase.instance.client.storage.createBucket(
      'imageBucket2',
      BucketOptions(
        public: false, // public access 설정
        allowedMimeTypes: [
          FileMimeType.imageAll.value, // 저장하는 파일 mime - type 설정
        ],
        fileSizeLimit: FileSizeLimit.image, // 파일 크기 설정
      ),
    );
    return Scaffold(
      body: Container(),
    );
  }
}
