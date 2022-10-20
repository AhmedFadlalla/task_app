import 'package:equatable/equatable.dart';

class BaseDashboardData extends Equatable{

  final int newTasks,inProgressTasks,completedTasks,outdatedTasks,allTasks;


  BaseDashboardData(
      {
      required  this.newTasks,
        required this.inProgressTasks,
        required this.completedTasks,
        required this.outdatedTasks,
        required this.allTasks,
      });

  @override
  // TODO: implement props
  List<Object?> get props => [
    newTasks,inProgressTasks,
    completedTasks,outdatedTasks,allTasks
  ];

}