import 'package:task_app/domain/entities/base_auth_data.dart';

class AuthDataModel extends BaseAuthData{
  AuthDataModel({required super.token});
  
  
  factory AuthDataModel.fromJson(Map<String,dynamic> json){
    return AuthDataModel(token: json["token"]);
  }
  
  
  
}

