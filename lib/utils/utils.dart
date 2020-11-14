import 'dart:convert';

import 'package:hizli_siparis/constants/urls.dart';
import 'package:http/http.dart' as http;

httpRequest(url, headers) async {
  final response = await http.get('$apiUrl/$url', headers: headers);
  return jsonDecode(response.body);
}

httpRequestPost(url, headers, body) async {
  final response =
      await http.post('$apiUrl/$url', headers: headers, body: body);
  return jsonDecode(response.body);
}
