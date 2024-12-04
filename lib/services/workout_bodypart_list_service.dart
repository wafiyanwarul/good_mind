import "dart:convert";
import "package:http/http.dart" as http;

class WorkoutBodyPartListService {
  static const String _baseUrl = "https://exercisedb.p.rapidapi.com/exercises/bodyPartList";
  static const Map<String, String> _headers = {
    'X-Rapidapi-Host': 'exercisedb.p.rapidapi.com',
    'X-Rapidapi-Key': 'YOUR_API_KEY',
  };

  Future<List<String>> fetchBodyPartList() async {
    final response = await http.get(Uri.parse(_baseUrl), headers: _headers);

    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load body parts');
    }
  }
}
