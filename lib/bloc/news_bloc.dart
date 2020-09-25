import 'package:rxdart/rxdart.dart';
import 'package:teste_gb/model/news_response.dart';

import 'file:///P:/personalProjects/teste_gb/lib/services/news/news_repository.dart';

class NewsBloc {

  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<NewsResponse> _subject =
      BehaviorSubject<NewsResponse>();

  getNews() async {

    NewsResponse response = await _repository.getNews();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<NewsResponse> get subject => _subject;

}

final newsBloc = NewsBloc();

abstract class NewsDataProvider {
  Future<NewsResponse> getNews();
}