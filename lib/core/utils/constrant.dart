import 'package:equatable/equatable.dart';

class UserParameter extends Equatable{
   final String name ;
   final  String email;
   final String password;


   UserParameter({
     required this.name,
    required this.email,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name,email,password];

}

class TaskParameter extends Equatable{
int? taskId;
  final String title;
  final String description;
  final String imagePath;
  final String imageName;
  final String? voice;
  final String startDate;
  final String endDate;


  TaskParameter(
      {
        this.taskId,
        required this.title,
        required this.description,
        required this.imagePath,
        required this.imageName,
         this.voice,
        required this.startDate,
        required this.endDate,
       });

  @override
  // TODO: implement props
  List<Object?> get props => [taskId,title,description,imagePath,imageName,voice,startDate,endDate];

}

class StatusParameter extends Equatable{
  final String name ;
  final int? id;


  StatusParameter({
    required this.name,
    this.id

  });

  @override
  // TODO: implement props
  List<Object?> get props => [name];

}
String? uId;
