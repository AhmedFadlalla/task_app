import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_app/core/utils/enum.dart';
import 'package:task_app/domain/entities/base_dash_board_data.dart';

import '../../../domain/entities/base_task_data.dart';

class HomeState extends Equatable {
   final List<BaseTaskData> tasksData;
  final RequestState tasksDataState;
  final String tasksDataMessage;
  final BaseDashboardData? dashboardData;
  final RequestState dashboardDataState;
  final String dashboardDataMessage;
  final XFile? image;
  final RequestState sendTaskState;
  final String sendTaskMessage;
  final String dropDownValue;
   final RequestState updateTaskState;
   final String updateTaskMessage;
   final BaseTaskData? taskData;
   final RequestState taskDataState;
   final String taskDataMessage;



  HomeState({
    this.tasksData=const [],
    this.tasksDataState=RequestState.loading,
    this.tasksDataMessage='',
    this.taskData,
    this.taskDataState=RequestState.loading,
    this.taskDataMessage='',
    this.dashboardData,
    this.dashboardDataState=RequestState.loading,
    this.dashboardDataMessage='',
    this.sendTaskState=RequestState.loading,
    this.sendTaskMessage='',
    this.updateTaskState=RequestState.loading,
    this.updateTaskMessage='',
    this.image,
    this.dropDownValue='',
  });
  HomeState copyWith({
    List<BaseTaskData>? tasksData,
    RequestState? tasksDataState,
    String? tasksDataMessage,
    BaseDashboardData? dashboardData,
    RequestState? dashboardDataState,
    String? dashboardDataMessage,
    XFile? image,
     RequestState? sendTaskState,
     String? sendTaskMessage,
    String? dropDownValue,
     RequestState? updateTaskState,
     String? updateTaskMessage,
     BaseTaskData? taskData,
     RequestState? taskDataState,
     String? taskDataMessage,
})=>HomeState(
      tasksData:tasksData??this.tasksData,
      tasksDataState:tasksDataState??this.tasksDataState,
      tasksDataMessage:tasksDataMessage??this.tasksDataMessage,
    dashboardData:dashboardData??this.dashboardData,
    dashboardDataState:dashboardDataState??this.dashboardDataState,
    dashboardDataMessage:dashboardDataMessage??this.dashboardDataMessage,
    image: image??this.image,
    dropDownValue: dropDownValue??this.dropDownValue,
    sendTaskState: sendTaskState??this.sendTaskState,
    sendTaskMessage: sendTaskMessage??this.sendTaskMessage,
    updateTaskMessage: updateTaskMessage??this.updateTaskMessage,
    updateTaskState: updateTaskState??this.updateTaskState,
      taskData:taskData??this.taskData,
    taskDataState: taskDataState??this.taskDataState,
      taskDataMessage:taskDataMessage??this.taskDataMessage

  );

  @override
  // TODO: implement props
  List<Object?> get props => [
    tasksData,tasksDataState,tasksDataMessage,
    dashboardData,dashboardDataState,dashboardDataMessage,
    image,dropDownValue,updateTaskMessage,updateTaskState,
    taskData,taskDataMessage,taskDataState
  ];




}
