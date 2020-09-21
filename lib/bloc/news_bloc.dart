import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:teste_gb/model/message.dart';
import 'package:teste_gb/model/news.dart';
import 'package:teste_gb/model/news_response.dart';
import 'package:teste_gb/model/user.dart';
import 'package:teste_gb/services/repository.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<NewsResponse> _subject = BehaviorSubject<NewsResponse>();

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
