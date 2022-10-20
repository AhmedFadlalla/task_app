import 'package:dio/dio.dart';

class DioHelper{

   static late Dio dio;


  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl:'https://tasks.eraasoft.com/api/',
        receiveDataWhenStatusError: true,


      )

    );

  }

 static Future<Response> getData({
     required String url,
     Map<String,dynamic>? query,
     String lang='en',
     String? token,
})async{
   dio.options.headers = {
     'Authorization' : 'Bearer $token',
   };
   return await dio.get(url,queryParameters: query);
}

static Future<Response> postData({
  required String url,
  Map<String,dynamic>? query,
   dynamic data,
  String lang='en',
  String? token,
})async{
  try{
    dio.options.headers = {
      'Authorization' : 'bearer $token',
    };
    return   await dio.post(url,queryParameters: query,data: data);
  }catch(error){
    print(error.toString());
    rethrow;
  }

}

   static Future<Response> putData(
       {
         required String url,
         dynamic? data,
         Map<String, dynamic>? query,
         String? token,
       }
       ) async {
     try{
       dio.options.headers = {
         'Authorization' : 'bearer $token',
       };
       Response response = await dio.put(
         url,
         data: data,
         queryParameters: query,
       );
       return response;
     }catch(error){
       throw error;
     }
   }

}