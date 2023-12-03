import 'package:http/http.dart' as http;
import 'dart:convert';

import '../valores/shered_preference.dart';

class ApiService {
  static Future<List<Map<String, dynamic>>> fetchLocationsFromAPI() async {
    // Substitua esta parte pela lógica real de consumo da API
    // Por exemplo, faça a requisição HTTP para obter os dados da API
final response = await http.get(Uri.parse(MySharedPreferences.ip+"/estacao/listaEstacao"));
    if (response.statusCode == 200) {
      var apiData = json.decode(response.body) as List;
      return apiData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Falha ao carregar os dados da API.');
    }
  }
}
