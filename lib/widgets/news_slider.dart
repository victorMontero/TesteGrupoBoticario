import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_gb/bloc/news_bloc.dart';
import 'package:teste_gb/elements/error_element.dart';
import 'package:teste_gb/elements/loader_element.dart';
import 'package:teste_gb/model/news.dart';
import 'package:teste_gb/model/news_response.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:teste_gb/style/theme.dart' as Style;


class NewsSliderWidget extends StatefulWidget {
  @override
  _NewsSliderWidgetState createState() => _NewsSliderWidgetState();
}

class _NewsSliderWidgetState extends State<NewsSliderWidget> {

  Size deviceSize;


  @override
  void initState() {
    super.initState();
    newsBloc.getNews();
  }

  @override
  Widget build(BuildContext context) {
    if (deviceSize == null) deviceSize = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
            height: deviceSize.height,
            viewportFraction: 0.9,
          ),
          items: getExpandedSlider(articles)),
    );
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
                foregroundDecoration: BoxDecoration(
                  color: Style.MyColors.greenColor,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  shape: BoxShape.rectangle,
                ),),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [
                      0.1,
                      0.7
                    ],
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.white.withOpacity(0.0)
                    ]),
              ),
            ),

            Positioned(
                top: 20.0,
                child: Container(
                  padding: EdgeInsets.only(left: 24.0, right: 8.0),
                  width: 225.0,
                  child: Column(
                    children: <Widget>[
                      Text(
                        article.message.content,
                        softWrap: true,
                        style: TextStyle(
                            height: 1.2,
                            color: Colors.black45,
                            fontWeight: FontWeight.w700,
                            fontSize: 19.0),
                      ),
                    ],
                  ),
                )),
            Positioned(
              bottom: 16.0,left: 16.0,
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://res-4.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_170,w_170,f_auto,b_white,q_auto:eco/x5mjatz3g75hsnhfuck2"),
              ),
            ),
            Positioned(
                bottom: 32.0,
                left: 64.0,
                child: Text(
                  article.user.name,
                  style: TextStyle(color: Colors.white54, fontSize: 16.0),
                )),
            Positioned(
                bottom: 20.0,
                left: 66.0,
                child: Text(
                  timeUntil(DateTime.parse(article.message.createdAt)),
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white54, fontSize: 9.0),
                )),
          ],
        ),
      ),
    ),)
        .toList();
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


  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}