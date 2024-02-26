import 'package:dio/dio.dart';

Future<int> loginController(String username, String password) async {
  
  var dio = Dio(BaseOptions(baseUrl: 'http://192.168.100.7:4444'));

  try {

    var response = await dio.post(
      '/login',
      data: {'username': username, 'password': password},
    );

    print(response);
    print(response.statusCode);
    return response.statusCode!;

  } catch (e) {

    print('Error en la solicitud: $e');
    return -1;

  }
}