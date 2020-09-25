
import 'package:flutter_test/flutter_test.dart';
import 'package:teste_gb/services/news/news_api_provider.dart';


void main() {
  test('testa retorno api', (){

    NewsApiProvider provider = NewsApiProvider();
    var result = provider.getNews();
    expect(result.toString(), "Instance of \'Future<NewsResponse>\'");
  });
}
