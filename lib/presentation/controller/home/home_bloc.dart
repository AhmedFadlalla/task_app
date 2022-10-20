import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:task_app/core/use_case/base_use_case.dart';
import 'package:task_app/core/utils/constrant.dart';
import 'package:task_app/core/utils/enum.dart';

import '../../../domain/use_case/get_all_tasks_use_case.dart';
import '../../../domain/use_case/get_dashboard_data_use_case.dart';
import '../../../domain/use_case/get_task_data_use_case.dart';
import '../../../domain/use_case/send_task_data_use_case.dart';
import '../../../domain/use_case/update_task_data_use_case.dart';
import 'home_event.dart';
import 'home_state.dart';


class HomeBloc extends Bloc<BaseHomeEvent, HomeState> {

  final GetAllTasksUseCase getAllTasksUseCase;
  final GetDashboardDataUseCase getDashboardDataUseCase;
  final SendTaskDataUseCase sendTaskDataUseCase;
  final UpdateTaskDataUseCase updateTaskDataUseCase;
  final GetTaskDataUseCase getTaskDataUseCase;
  HomeBloc(this.getAllTasksUseCase, this.getDashboardDataUseCase,
      this.sendTaskDataUseCase,this.updateTaskDataUseCase,this.getTaskDataUseCase) : super(HomeState()) {
    on<GetDashboardDataEvent>((event, emit) async {
      final result = await getDashboardDataUseCase(const NoParameters());

      result.fold((l) =>
          emit(
              state.copyWith(
                  dashboardDataState: RequestState.error,
                  dashboardDataMessage: l.message
              )
          ), (r) =>
          emit(
              state.copyWith(
                  dashboardData: r,
                  dashboardDataState: RequestState.loaded
              )
          ));
    });
    on<GetAllTasksDataEvent>((event, emit) async {

        final result = await getAllTasksUseCase(StatusParameter(name: event.name));

        result.fold((l) =>
            emit(

                state.copyWith(
                    tasksDataState: RequestState.error,
                    tasksDataMessage: l.message
                )
            ), (r) =>
            emit(
                state.copyWith(
                    tasksData: r,
                    tasksDataState: RequestState.loaded
                )
            ));


    });
    on<GetImageFromGalleryEvent>((event, emit) async {
      final ImagePicker picker = ImagePicker();
      final file = await picker.pickImage(source: ImageSource.gallery);
      emit(
          state.copyWith(
              image: XFile(file!.path)
          )
      );
    });
    on<SendTaskDataEvent>((event, emit) async {
      final result = await sendTaskDataUseCase(
          TaskParameter(title: event.title,
              description: event.description,
              imagePath: event.imagePath,
              imageName: event.imageName,
              startDate: event.startDate,
              endDate: event.endDate,
          ));

      result.fold((l) =>
          emit(
              state.copyWith(
                  sendTaskState: RequestState.error,
                  sendTaskMessage: l.message
              )
          ), (r) =>
          emit(
              state.copyWith(
                  sendTaskState: RequestState.loaded
              )
          ));
    });
    on<GetTaskDataEvent>((event, emit)async{
      final result = await getTaskDataUseCase(
          StatusParameter(
           name: '',
            id:event.id
          ));

      result.fold((l) =>
          emit(
              state.copyWith(
                  taskDataState: RequestState.error,
                  taskDataMessage: l.message
              )
          ), (r) =>
          emit(
              state.copyWith(
                  taskDataState: RequestState.loaded,
                taskData:r
              )
          ));
    });
    on<UpdateTaskDataEvent>((event, emit) async {
      final result = await updateTaskDataUseCase(
          TaskParameter(
            taskId: event.taskId,
            title: event.title,
            description: event.description,
            imagePath: event.imagePath,
            imageName: event.imageName,
            startDate: event.startDate,
            endDate: event.endDate,
          ));

      result.fold((l) =>
          emit(
              state.copyWith(
                  updateTaskState: RequestState.error,
                  updateTaskMessage: l.message
              )
          ), (r) =>
          emit(
              state.copyWith(
                  updateTaskState: RequestState.loaded
              )
          ));
    });

  }
}
