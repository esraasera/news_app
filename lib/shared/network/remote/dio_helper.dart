import 'package:dio/dio.dart';

class DioHelper  {

  static Dio? dio ;

  static init(){
    dio = Dio(
        BaseOptions(
      baseUrl:'https://newsapi.org/v2/',
          receiveDataWhenStatusError: true,
          connectTimeout: Duration(milliseconds: 10000),
          receiveTimeout: Duration(milliseconds: 10000),
      )
    );

  }

  static Future<Response<dynamic>> getData({
    required String url,
    required Map<String,dynamic> query,
  })async{
    return await dio!.get(
      url,
      queryParameters:query,
    );
  }

}