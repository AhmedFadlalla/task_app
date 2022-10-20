import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final String statusCode;
  final String statusMessage;
  final int code;

   ErrorMessageModel({required this.statusCode,required this.statusMessage,required this.code});
  
  factory ErrorMessageModel.fromJson(Map<String,dynamic>json){
    return ErrorMessageModel(
        statusCode: json["status"],
        statusMessage: json["message"],
        code: json["code"]??0);


  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    statusCode,statusMessage,code
  ];


}
