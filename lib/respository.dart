import 'dart:developer';

import 'package:dionewsapidemo/articleModel.dart';
import 'package:dionewsapidemo/http_manager.dart';

class ApiData{
  final httpManager=HTTPManager();
  Future<List<Articles>> fetchArticleList()async {
    List<Articles> myList=[];
    final newsArticle=await httpManager.get(url:"top-headlines?country=us&category=business&apiKey=dd3b8315a8ce4c3ca4f6a3d6d3a75b4a",loading: true);
    newsArticle['articles'].forEach((element){
      myList.add(Articles.fromJson(element));
    });
    return myList;
  }
}