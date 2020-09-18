import 'package:teste_gb/model/news.dart';
import 'package:teste_gb/services/news_api_provider.dart';

class NewsRepository{
  NewsApiProvider _newsApiProvider = NewsApiProvider();

  Future<List<News>> fetchNews() => _newsApiProvider.fetchNews();
}