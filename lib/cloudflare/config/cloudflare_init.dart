import 'package:cloudflare/cloudflare.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudflareInit {
  const CloudflareInit();

  static void init() async {
    if (!dotenv.isInitialized) await dotenv.load(fileName: ".env");
    try {
      final cloudflare = await Cloudflare(
        accountId: dotenv.get("CLOUDFLARE_ACCOUNT_ID"),
        token: dotenv.get("CLOUDFLARE_TOKEN"),
      );
      await cloudflare.init();
    } catch (e) {
      print("Error!!!!!!");
      print(e);
    }
  }
}
