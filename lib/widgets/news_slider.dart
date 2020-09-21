import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:teste_gb/bloc/news_bloc.dart';
import 'package:teste_gb/elements/error_element.dart';
import 'package:teste_gb/elements/loader_element.dart';
import 'package:teste_gb/model/news.dart';
import 'package:teste_gb/model/news_response.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsSliderWidget extends StatefulWidget {
  @override
  _NewsSliderWidgetState createState() => _NewsSliderWidgetState();
}

class _NewsSliderWidgetState extends State<NewsSliderWidget> {
  @override
  void initState() {
    super.initState();
    newsBloc.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NewsResponse>(
      stream: newsBloc.subject.stream,
      builder: (context, AsyncSnapshot<NewsResponse> snapshot) {
        if (snapshot.hasData) {
          if(snapshot.data.error != null && snapshot.data.error.length > 0 ){
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildNewsSliderWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildNewsSliderWidget(NewsResponse data) {
    List<News> articles = data.news;
    return Container(
      child: CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: false,
            height: 200.0,
            viewportFraction: 0.9,
          ),
          items: getExpandedSlider(articles)),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error occured: $error"),
          ],
        ));
  }

  getExpandedSlider(List<News> articles) {
    return articles.map((article) => GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.only(
                left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
            child: Stack(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: article.user.profilePicture == null
                          ? AssetImage("assets/img/placeholder.jpg")
                          : NetworkImage(article.user.profilePicture)),
                )),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [
                          0.1,
                          0.9
                        ],
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.white.withOpacity(0.0)
                        ]),
                  ),
                ),
                Positioned(
                    bottom: 30.0,
                    child: Container(
                      padding: EdgeInsets.only( right: 10.0),
                      width: 250.0,
                      child: Column(
                        children: <Widget>[
                          Text(
                            article.user.name,
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                    bottom: 10.0,
                    left: 10.0,
                    child: Text(
                      article.message.content,
                      style: TextStyle(color: Colors.white54, fontSize: 8.0),
                    )),
                Positioned(
                    bottom: 10.0,
                    right: 10.0,
                    child: Text(
                      timeUntil(DateTime.parse(article.message.createdAt)),
                      style: TextStyle(color: Colors.white54, fontSize: 8.0),
                    )),
              ],
            ),
          ),
        ),)
        .toList();
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
