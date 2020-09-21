import 'package:teste_gb/model/news.dart';

class NewsResponse {
  final List<News> news;
  final String error;

  NewsResponse(this.news, this.error);

  NewsResponse.fromJson(Map<String, dynamic> json)
      : news =
            (json["news"] as List).map((i) => News.fromJson(i))
                .toList(),
        error = "";

  NewsResponse.withError(String errorValue)
      : news = List(),
        error = errorValue;
}
