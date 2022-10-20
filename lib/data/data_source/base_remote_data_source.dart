import 'package:dio/dio.dart';
import 'package:task_app/core/error/exceptions.dart';
import 'package:task_app/core/network/error_message_model.dart';
import 'package:task_app/core/services/dio_helper.dart';
import 'package:task_app/core/utils/constrant.dart';
import 'package:task_app/data/models/auth_data_model.dart';
import 'package:task_app/data/models/task_data_model.dart';

import '../../core/utils/end_point.dart';
import '../models/dashboard_data_model.dart';

abstract class BaseRemoteDataSource {

  Future<void> userSignUp(UserParameter parameter);
  Future<AuthDataModel> userSignIn(UserParameter parameter);
  Future<List<TaskDataModel>> getTasksByStatusData(StatusParameter parameter);
  Future<DashboardDataModel> getDashboardData();
  Future<TaskDataModel> sendTaskData(TaskParameter parameter);
  Future<TaskDataModel> updateTaskData(TaskParameter parameter);
  Future<TaskDataModel> getTaskData(StatusParameter parameter);
}

class RemoteDataSource extends BaseRemoteDataSource{
  @override
  Future<void> userSignUp(UserParameter parameter) async{
    await DioHelper.postData(url: register, data: {
      "name":parameter.name,
      "email":parameter.email,
      "password":parameter.password
    });

  }

  @override
  Future<AuthDataModel> userSignIn(UserParameter parameter)async {

    final response=await DioHelper.postData(url:login, query: {
      "email":parameter.email,
      "password":parameter.password
    });

    
    if(response.statusCode==200){
      return AuthDataModel.fromJson(response.data["authorisation"]);
    }else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data) );
    }
    
  }

  @override
  Future<List<TaskDataModel>> getTasksByStatusData(StatusParameter parameter) async{

    if(parameter.name==""){

      final response=await DioHelper.getData(url: tasks,token: uId);
      if(response.statusCode==200){
        return List<TaskDataModel>.from((response.data["response"]["data"] as List).map((e) => TaskDataModel.fromJson(e)));
      }else{
        throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data) );
      }
    }else{
      final response=await DioHelper.getData(url: tasks,token: uId,query: {
        "status":parameter.name
      });
      if(response.statusCode==200){
        return List<TaskDataModel>.from((response.data["response"]["data"] as List).map((e) => TaskDataModel.fromJson(e)));
      }else{
        throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data) );
      }
    }



  }

  @override
  Future<DashboardDataModel> getDashboardData() async{
   final response=await DioHelper.getData(url:dashboard,token: uId);
   if(response.statusCode==200){
     return DashboardDataModel.fromJson(response.data["0"]);
   }else{
     throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data) );
   }
  }

  @override
  Future<TaskDataModel> sendTaskData(TaskParameter parameter) async{
    FormData data=FormData.fromMap({
        "title":parameter.title,
        "description":parameter.description,
        "image":await MultipartFile.fromFile(parameter.imagePath,filename: parameter.imageName),
        "start_date":parameter.startDate,
        "end_date":parameter.endDate
    });

    final response=await DioHelper.postData(url: tasks,data: data,token: uId);
    print(response.statusCode);
    if(response.statusCode==201){
      print(response.data["response"]);
      return TaskDataModel.fromJson(response.data["response"]);

    }else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data) );
    }
  }

  @override
  Future<TaskDataModel> updateTaskData(TaskParameter parameter) async{
    FormData data=FormData.fromMap({
      "title":parameter.title,
      "description":parameter.description,
      "image":await MultipartFile.fromFile(parameter.imagePath,filename: parameter.imageName),
      "start_date":parameter.startDate,
      "end_date":parameter.endDate
    });

    final response=await DioHelper.putData(url: getTaskId(parameter.taskId!),data: data,token: uId);
    print(response.statusCode);
    if(response.statusCode==202){
      print(response.data["response"]);
      return TaskDataModel.fromJson(response.data["response"]);

    }else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data) );
    }
  }

  @override
  Future<TaskDataModel> getTaskData(StatusParameter parameter) async{
    final response=await DioHelper.getData(url:getTaskId(parameter.id!),token: uId);
    if(response.statusCode==200){
      return TaskDataModel.fromJson(response.data["response"]);
    }else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data) );
    }
  }
}