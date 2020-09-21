part of 'news_bloc.dart';

abstract class NewsEvent {}

class GetNews extends NewsEvent {
  final User user;
  final Message message;

  GetNews({@required this.user, this.message})
      : assert(user != null, message != null);
}
