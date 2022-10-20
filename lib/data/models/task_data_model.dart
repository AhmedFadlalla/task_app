import 'package:task_app/domain/entities/base_task_data.dart';

class TaskDataModel extends BaseTaskData {
  TaskDataModel(
      {required super.id,
      required super.userId,
      required super.title,
      required super.description,
      required super.image,
      required super.voice,
      required super.startDate,
      required super.endDate,
      required super.status,
      required super.createdAt,
      required super.updatedAt,
      required super.imageUrl,
      required super.voiceUrl});

  factory TaskDataModel.fromJson(Map<String, dynamic> json) {
    return TaskDataModel(
      id: json["id"],
      userId:json["user_id"] ,
      title:json["title"] ,
      description:json["description"] ,
      image:json["image"]??"" ,
      voice: json["voice"]??"",
      startDate:json["start_date"],
      endDate:json["end_date"] ,
      status:json["status"]??"new" ,
      createdAt:json["created_at"] ,
      updatedAt:json["updated_at"] ,
      imageUrl:json["image_url"],
      voiceUrl:json["voice_url"] ,
    );
  }
}
