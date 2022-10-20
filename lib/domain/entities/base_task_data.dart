import 'package:equatable/equatable.dart';

class BaseTaskData extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String description;
  final String image;
  final String voice;
  final String startDate;
  final String endDate;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String imageUrl;
  final String voiceUrl;

  BaseTaskData(
      {required this.id,
      required this.userId,
      required this.title,
      required this.description,
      required this.image,
      required this.voice,
      required this.startDate,
      required this.endDate,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.imageUrl,
      required this.voiceUrl});

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,userId,title,description,image,voice,startDate,endDate,status,
    createdAt,updatedAt,imageUrl,voiceUrl
  ];


}
