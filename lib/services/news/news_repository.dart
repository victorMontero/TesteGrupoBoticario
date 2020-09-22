import 'package:teste_gb/model/news_response.dart';
import 'file:///P:/personalProjects/teste_gb/lib/services/news/news_api_provider.dart';

class NewsRepository {
  NewsApiProvider _apiProvider = NewsApiProvider();

  Future<NewsResponse> getNews() {
    return _apiProvider.getNews();
  }
}
