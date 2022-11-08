

import 'package:get_it/get_it.dart';
import 'package:task_app/data/data_source/base_remote_data_source.dart';
import 'package:task_app/domain/use_case/get_all_tasks_use_case.dart';
import 'package:task_app/domain/use_case/get_dashboard_data_use_case.dart';
import 'package:task_app/domain/use_case/send_task_data_use_case.dart';
import 'package:task_app/domain/use_case/user_sign_up_use_case.dart';
import 'package:task_app/presentation/controller/home/home_bloc.dart';
import 'package:task_app/presentation/controller/home/home_event.dart';
import 'package:task_app/presentation/controller/register/register_bloc.dart';

import '../../data/repo/app_repo.dart';
import '../../domain/repo/base_app_repo.dart';
import '../../domain/use_case/delete_task_use_case.dart';
import '../../domain/use_case/get_task_data_use_case.dart';
import '../../domain/use_case/update_task_data_use_case.dart';
import '../../domain/use_case/user_sign_in_use_case.dart';


final sl=GetIt.instance;
class ServicesLocator{
  void init(){
    //Bloc


    sl.registerLazySingleton<RegisterBloc>(() =>RegisterBloc(sl(),sl()));
    sl.registerLazySingleton<HomeBloc>(() =>HomeBloc(sl(),sl(),sl(),sl(),sl(),sl()));
    // كل ما بنادي ع بلوك هيعمل نيو اوبجكت علشان يجيب الداتا جديده
    //use case

    sl.registerLazySingleton<UserSignUpUseCase>(() =>UserSignUpUseCase(sl()));
    sl.registerLazySingleton<UserSignInUseCase>(() =>UserSignInUseCase(sl()));
    sl.registerLazySingleton<GetAllTasksUseCase>(() =>GetAllTasksUseCase(sl()));
    sl.registerLazySingleton<GetDashboardDataUseCase>(() =>GetDashboardDataUseCase(sl()));
    sl.registerLazySingleton<SendTaskDataUseCase>(() =>SendTaskDataUseCase(sl()));
    sl.registerLazySingleton<GetTaskDataUseCase>(() =>GetTaskDataUseCase(sl()));
    sl.registerLazySingleton<UpdateTaskDataUseCase>(() =>UpdateTaskDataUseCase(sl()));
    sl.registerLazySingleton<DeleteTaskUseCase>(() =>DeleteTaskUseCase(sl()));
    // sl.registerLazySingleton<>(() =>(sl()));
    //Repository
    sl.registerLazySingleton<BaseAppRepository>(() =>AppRepository(sl()) );
    //data source
    sl.registerLazySingleton<BaseRemoteDataSource>(() =>RemoteDataSource());
  }

}