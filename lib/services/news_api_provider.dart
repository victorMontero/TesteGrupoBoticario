import'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:teste_gb/model/news.dart';
import 'package:teste_gb/model/news_response.dart';

class NewsApiProvider{

  String baseUrl = "https://gb-mobile-app-teste.s3.amazonaws.com/data.json";
  final successCode = 200;

  Future<List<News>> fetchNews() async{
    final response = await http.get(baseUrl);
    return parseResponse(response);
  }


  List<News> parseResponse(http.Response response){
    final responseString = jsonDecode(response.body);

    if(response.statusCode == successCode){
      return NewsResponse.fromJson(responseString).news;
    } else {
      throw Exception('failed to load news : (');
    }
  }
}