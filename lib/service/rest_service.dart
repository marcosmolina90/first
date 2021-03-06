import 'dart:convert';

import 'package:first/model/time.dart';
import 'package:first/service/intercept_http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

class RestService {
  Client client = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);

  Uri getUri(String service, param) {
    return Uri.http('localhost:8080', service, param);
  }

  Future<Map<String, dynamic>> getter(String service, param) async {
    var ret;
    try {
      var url = getUri(service, param);

      final response = await client.get(url);
      if (response.statusCode == 200) {
        ret = json.decode(response.body);
      } else {
        throw Exception("Error while fetching. \n ${response.body}");
      }
    } catch (e) {
      print(e);
    }
    return ret;
  }

  Future<List> list(String service, param) async {
    var ret;

    var url = getUri(service, param);

    final response = await client.get(url);
    if (response.statusCode == 200) {
      ret = json.decode(response.body);
    } else {
      throw Exception("Error while fetching. \n ${response.body}");
    }

    return ret;
  }

  Future<void> save(String service, obj) async {
    var url = getUri(service + "/insert", null);
    final response = await client.post(url, body: jsonEncode(obj));

    if (response.statusCode != 200) {
      throw Exception("Erro ao salvar \n ${response.body}");
    }
  }

  Future<void> update(String service, obj) async {
    var url = getUri(service + "/update", null);
    final response = await client.post(url, body: jsonEncode(obj));
    if (response.statusCode != 200) {
      throw Exception("Erro ao atualizar \n ${response.body}");
    }
  }
}
