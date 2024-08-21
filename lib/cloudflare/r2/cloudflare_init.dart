import 'package:cloudflare/cloudflare.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudflareInit {
  const CloudflareInit();

  static void init() async {
    if (!dotenv.isInitialized) await dotenv.load(fileName: ".env");
    await Cloudflare(accountId: dotenv.get("ACCOUNT_ID"));
  }
}
