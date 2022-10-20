import 'package:equatable/equatable.dart';


class AppContances{
  static const baseUrl="https://jsonplaceholder.typicode.com";
  static const getPostsUrl="$baseUrl/posts";
}

class NoParameters extends Equatable{
  const NoParameters();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

