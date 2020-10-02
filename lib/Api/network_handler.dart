import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  String baseUrl = 'http://10.0.3.2:3000';

  final logger = Logger();
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future get(String url) async {
    url = formatter(url);
    String token = await _storage.read(key: "token");
    print(token);

    var res = await http.get(url, headers: {'Cookie': 'w_auth=$token'});

    if (res.statusCode == 201 || res.statusCode == 200) {
      return json.decode(res.body);
    }

    logger.i(res.body);
    logger.i(res);
    logger.i(res.statusCode);
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = formatter(url);
    String token = await _storage.read(key: "token");
    print('cookies $token');

    var res = await http.post(url,
        headers: {
          "Content-type": "application/json",
          "Cookie": 'w_auth=$token'
        },
        body: json.encode(body));

    if (res.statusCode == 201 || res.statusCode == 200) {
      logger.i(res);
      logger.i(res.statusCode);
    }

    logger.d(res.body);
    logger.d(res.statusCode);
    return res;
  }

  Future<http.StreamedResponse> patchImage(String url, String filePath) async {
    url = formatter(url);
    String token = await _storage.read(key: "token");
    final request = http.MultipartRequest("PATCH", Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("file", filePath));
    request.headers.addAll(
        {"Content-type": "multipart/form-data", "Cookie": 'w_auth=$token'});
    final res = request.send();
    
    logger.i(request);
    logger.d(res);
    return res; 
     }

    NetworkImage getImage(String username) {
    String url = formatter("/uploads//$username.jpg");
    return NetworkImage(url);
  }

  String formatter(String url) {
    return baseUrl + url;
  }
}
