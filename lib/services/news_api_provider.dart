import 'package:dio/dio.dart';
import 'package:teste_gb/model/news_response.dart';

class NewsApiProvider {
  final String _mainUrl =
      "https://gb-mobile-app-teste.s3.amazonaws.com/data.json";
  final _dio = Dio();

  Future<NewsResponse> getNews() async {
    try {
      Response response = await _dio.get(_mainUrl);
      return NewsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return NewsResponse.withError("$error");
    }
  }
}
