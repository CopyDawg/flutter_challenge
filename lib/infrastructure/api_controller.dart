import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<Map<String, dynamic>>> fetchData(String country) async {
  try {
    var dio = Dio(BaseOptions(
      baseUrl: 'https://v3.football.api-sports.io',
      queryParameters: {
        'country': country,
      },
      headers: {
        'x-rapidapi-key': dotenv.env['API_KEY'],
      }
    ));

    final response = await dio.get('/teams');
    Map<String, dynamic> decodedResponse = response.data;
    // Convertir explícitamente cada elemento de la lista a un mapa
    List<Map<String, dynamic>> responseValues = List<Map<String, dynamic>>.from(decodedResponse['response']);

    return responseValues;

  } catch (e) {
    print('Error al obtener los datos: $e');
    return [];
  }
}