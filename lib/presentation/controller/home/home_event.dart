import 'package:equatable/equatable.dart';

abstract class BaseHomeEvent extends Equatable{
  BaseHomeEvent();
  @override
  List<Object?> get props => [];
}

class GetAllTasksDataEvent extends BaseHomeEvent{
  final String name;

  GetAllTasksDataEvent({
    required this.name
  });
}
class GetDashboardDataEvent extends BaseHomeEvent{}
class GetImageFromGalleryEvent extends BaseHomeEvent{}
class SendTaskDataEvent extends BaseHomeEvent{
  final String title;
  final String description;
  final String imagePath;
  final String imageName;
  final String? voice;
  final String startDate;
  final String endDate;


  SendTaskDataEvent(
      {
        required this.title,
        required this.description,
        required this.imagePath,
        required this.imageName,
        this.voice,
        required this.startDate,
        required this.endDate,
      });
}
class ChangeDropDownBottom extends BaseHomeEvent{
   final String value;
  ChangeDropDownBottom(
      {
       required this.value
      });
}
class GetTaskDataEvent extends BaseHomeEvent{
  final int  id;
  GetTaskDataEvent(
      {
        required this.id
      });
}
class UpdateTaskDataEvent extends BaseHomeEvent{
  final int taskId;
  final String title;
  final String description;
  final String imagePath;
  final String imageName;
  final String? voice;
  final String startDate;
  final String endDate;


  UpdateTaskDataEvent(
      {
        required this.taskId,
        required this.title,
        required this.description,
        required this.imagePath,
        required this.imageName,
        this.voice,
        required this.startDate,
        required this.endDate,
      });
}