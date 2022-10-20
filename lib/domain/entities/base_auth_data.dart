import 'package:equatable/equatable.dart';

class BaseAuthData extends Equatable{
  final String token;


  BaseAuthData({required this.token});

  @override
  // TODO: implement props
  List<Object?> get props =>[
    token
  ];



}