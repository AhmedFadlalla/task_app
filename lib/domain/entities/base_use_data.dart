import 'package:equatable/equatable.dart';

class BaseUserData extends Equatable {
  final String name;
  final String email;
  final String password;

  BaseUserData({
   required this.name,
    required this.email,
    required  this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name,email,password];


}
