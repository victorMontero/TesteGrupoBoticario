import 'package:flutter/material.dart';
import 'package:teste_gb/widgets/news_slider.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  @override
  Widget build(BuildContext context) {

    return NewsSliderWidget();
  }
}
