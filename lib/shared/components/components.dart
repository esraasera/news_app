import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/webview/webview_screen.dart';

Widget buildArticleItem(article,context) =>  InkWell(
  onTap: (){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebViewScreen(article['url']),
        ),
    );
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CachedNetworkImage(
          imageUrl: '${article['urlToImage']}',
          placeholder: (context,url)=> Center(
            child: SizedBox(
              width: 60.0,
              height: 60.0,
              child: CircularProgressIndicator(
                   color: Colors.deepOrange,
              ),

            ),

          ),

          errorWidget:(context,url,error)=>const Icon(
            Icons.error_outline,
            color: Colors.deepOrange,
            size: 30.0,
          ),
          height: 120.0,
          width: 120.0,
          errorListener:(value) {
          },
          imageBuilder:(context,imageProvider){
            return Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image:imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          } ,
        ),

        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: SizedBox(
            height: 120.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                  '${article['title']}',
                    maxLines: 3,
                    overflow:TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),

                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget articleBuilder(list,context, {isSearch = false})=>ConditionalBuilder(
  condition:list.length > 0,
  builder: (BuildContext context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context,index) => buildArticleItem(list[index], context),
    separatorBuilder: (context,index) => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 40.0,
      ),
      child: Container(
        width:double.infinity,
        height:1.0 ,
        color: Colors.grey[300],
      ),
    ),
    itemCount: list.length,
  ),
  fallback: (BuildContext context) => isSearch ?Container() : Center( child: CircularProgressIndicator(color: Colors.deepOrange,)),

);

