import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:android_telecare_pkm/constants.dart';

class HttpUtil {
  Future<String> req(String path, {Map? headers, Map? body}) async {
    // Future<Map> req(String path, {Map? headers, Map? body}) async {
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
      String respBody = await httpresp.transform(utf8.decoder).join();
      // String respBody = await response.transform(utf8.decoder).join();
      // var jsonResp = jsonDecode(respBody);

      // return jsonResp;
      // return respBody;
      print(respBody);
      return respBody;
    } catch (err) {
      print(err);
      print(err.toString());
      throw Exception("Error when handling response");
    }
  }

  Future<String> reqget(String path, {Map? headers, Map? body}) async {
    // Future<Map> reqget(String path, {Map? headers, Map? body}) async {
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
      // var jsonResp = jsonDecode(respBody);

      // return jsonResp;
      print(respBody);
      return respBody;
    } catch (err) {
      print(err);
      throw Exception("Error when handling response");
    }
  }
}
