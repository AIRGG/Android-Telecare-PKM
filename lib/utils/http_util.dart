import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:android_telecare_pkm/constants.dart';

class HttpUtil {
  Future<Map> req(String path, {Map? headers, Map? body}) async {
    HttpClient httpClient = new HttpClient();
    HttpClientResponse response;
    try {
      headers ??= {};

      String url = !path.contains("http") ? '${apiUrl}${path}' : path;

      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(body)));
      response = await request.close();
      print(request.toString());
    } catch (err) {
      print(err.toString());
      throw Exception("Error when handling request");
    } finally {
      httpClient.close();
    }

    try {
      HttpClientResponse httpresp = response;
      print(httpresp.toString());
      String respBody = await httpresp.transform(utf8.decoder).join();
      // String respBody = await response.transform(utf8.decoder).join();
      var jsonResp = jsonDecode(respBody);

      return jsonResp;
    } catch (err) {
      print(err);
      print(err.toString());
      throw Exception("Error when handling response");
    }
  }

  Future<Map> reqget(String path, {Map? headers, Map? body}) async {
    HttpClient httpClient = new HttpClient();
    HttpClientResponse response;
    try {
      headers ??= {};

      String url = !path.contains("http") ? '${apiUrl}${path}' : path;

      HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
      // request.headers.set('content-type', 'application/json');
      // request.add(utf8.encode(json.encode(body)));
      response = await request.close();
    } catch (err) {
      print(err);
      throw Exception("Error when handling request");
    } finally {
      httpClient.close();
    }

    try {
      String respBody = await response.transform(utf8.decoder).join();
      var jsonResp = jsonDecode(respBody);

      return jsonResp;
    } catch (err) {
      print(err);
      throw Exception("Error when handling response");
    }
  }
}
