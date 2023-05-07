import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'news_provider.dart';


class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NewsProvider>(context, listen: false).fetchNewsData();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title:const Text("Bussiness HeadLine"),backgroundColor:Colors.black,centerTitle: true,),
      body:Consumer<NewsProvider>(
          builder: (context,newsProvider,_){
            return
              ListView.builder(
                itemCount: newsProvider.articles.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: w * 0.8,
                      height: h * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:NetworkImage( newsProvider.articles[index].urlToImage!))
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            //color: Colors.transparent,
                            gradient:const LinearGradient(
                              colors: [Colors.transparent, Colors.black],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 0.06 * w,
                            right: 0.06 * w,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                newsProvider.articles[index].title!,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style:const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    //overflow: TextOverflow.ellipsis,

                                    color: Colors.white),
                              ),
                              Row(
                                children: [
                                  Text(
                                    newsProvider.articles[index].source!.name!,
                                    style:const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  Spacer(),
                                  Text(
                                    newsProvider.articles[index].urlToImage
                                        .toString()
                                        .substring(0, 11),
                                    style:const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
          }) ,
    );
  }
}
