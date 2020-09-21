part of 'news_bloc.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState{}

class NewsLoaded extends NewsState{
  final List<News> news;
  NewsLoaded({@required this.news});

}

class NewsError extends NewsState{}

class NewsEmpty extends NewsState{}