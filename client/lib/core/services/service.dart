import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // next three lines makes this class a Singleton
  static ApiService _instance = new ApiService.internal();
  ApiService.internal();
  factory ApiService() => _instance;
  HttpClient httpClient = new HttpClient();
  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    print(body);
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      debugPrint('Hola post response');
      print(response);
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 404) {
        print(res);
        throw statusCode;
      }

      if (statusCode < 200 || statusCode >= 400 || json == null) {
        print(res);
        throw statusCode;
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> get(String url, String token, {Map headers, body, encoding}) {
    print(token);
    return http
        .get(url,
            headers:
            {HttpHeaders.authorizationHeader: 'Bearer ' + token},)
        .then((http.Response response) {
      debugPrint('Hola get response');
      final int statusCode = response.statusCode;

      if (statusCode == 404) {
        throw statusCode;
      }

      if (statusCode < 200 || statusCode >= 400 || json == null) {
        throw statusCode;
      }
      return _decoder.convert(response.body);
    });
  }

  Future<dynamic> put(String url, String token, {Map headers, body, encoding}) {
    print(token);
    print(url);
    print(body);
    return http.put(
            url,
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer ' + token,
              "Content-Type" : "application/json",
              "Accept" : "application/json",
            },
            body: jsonEncode(body),)
        .then((http.Response response) {
      debugPrint('Hola put response');
      final int statusCode = response.statusCode;
      print(statusCode);
      if (statusCode == 404) {
        throw statusCode;
      }

      if (statusCode < 200 || statusCode >= 400 || json == null) {
        throw statusCode;
      }
      return _decoder.convert(response.body);
    });
  }

  Future<dynamic> postCreate(String url, String token, {Map headers, body, encoding}) {
    print(token);
    print(url);
    print(body);
    return http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token,
        "Content-Type" : "application/json",
        "Accept" : "application/json",
      },
      body: jsonEncode(body),)
        .then((http.Response response) {
      debugPrint('Hola put response');
      final int statusCode = response.statusCode;
      print(statusCode);
      if (statusCode == 404) {
        throw statusCode;
      }

      if (statusCode < 200 || statusCode >= 400 || json == null) {
        throw statusCode;
      }
      return _decoder.convert(response.body);
    });
  }
}
