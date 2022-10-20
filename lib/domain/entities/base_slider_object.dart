import 'package:equatable/equatable.dart';

class BaseSliderObject extends Equatable{
  final String title;
  final String subTitle;
  final String image;

  BaseSliderObject(this.title, this.subTitle, this.image);

  @override
  // TODO: implement props
  List<Object?> get props => [
    title,subTitle,image
  ];
}