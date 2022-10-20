import '../../domain/entities/base_dash_board_data.dart';

class DashboardDataModel extends BaseDashboardData {
  DashboardDataModel({required super.newTasks,
    required super.inProgressTasks,
    required super.completedTasks,
    required super.outdatedTasks,
    required super.allTasks});

  factory DashboardDataModel.fromJson(Map<String, dynamic>json){
    return DashboardDataModel(
        newTasks: json["new tasks"],
        inProgressTasks: json["in progress tasks"],
        completedTasks: json["completed tasks"],
        outdatedTasks: json["outdated tasks"],
        allTasks:json["all tasks"] );
  }
}
