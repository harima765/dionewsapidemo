import 'package:dionewsapidemo/respository.dart';
import 'package:flutter/cupertino.dart';

import 'articleModel.dart';

class NewsProvider extends ChangeNotifier{
  List<Articles> articles=[];
  void fetchNewsData() async{
    articles= await ApiData().fetchArticleList();
    notifyListeners();
  }
}