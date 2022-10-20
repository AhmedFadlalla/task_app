import 'package:task_app/domain/entities/base_use_data.dart';

class UserDataModel extends BaseUserData{
  UserDataModel({required super.name, required super.email, required super.password});

  factory UserDataModel.fromJson(Map<String,dynamic> json){
    return UserDataModel(name: json["name"], email: json["email"], password: json["password"]);
  }

}