import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nasa_api/models/potd.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Potd>?> getPotd() async {
    var client = http.Client();
    var uri = Uri.parse(dotenv.env["NASA_API"]!);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return potdFromJson(json);
    }
  }
}
