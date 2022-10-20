import 'package:dartz/dartz.dart';
import 'package:task_app/core/error/failure.dart';
import 'package:task_app/core/utils/constrant.dart';
import 'package:task_app/data/data_source/base_remote_data_source.dart';
import 'package:task_app/domain/entities/base_auth_data.dart';
import 'package:task_app/domain/entities/base_dash_board_data.dart';
import 'package:task_app/domain/entities/base_task_data.dart';
import 'package:task_app/domain/repo/base_app_repo.dart';

class AppRepository extends BaseAppRepository{
  final BaseRemoteDataSource baseRemoteDataSource;


  AppRepository(this.baseRemoteDataSource);

  @override
  Future<Either<Failure, void>> userSignUp(UserParameter parameter) async{
    await baseRemoteDataSource.userSignUp(parameter);

    try{
      return Right(print("Send Successfully"));
    }on ServerFailure catch(failure){
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, BaseAuthData>> userSignIn(UserParameter parameter)async {
    final result=await baseRemoteDataSource.userSignIn(parameter);
    try{
      return Right(result);
    }on ServerFailure catch(failure){
      return Left(ServerFailure(failure.message));
    }

  }

  @override
  Future<Either<Failure, List<BaseTaskData>>> getTasksByStatus(StatusParameter parameter) async{
    final result=await baseRemoteDataSource.getTasksByStatusData(parameter);
    try{
      return Right(result);
    }on ServerFailure catch(failure){
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, BaseDashboardData>> getDashboardData() async{
    final result=await baseRemoteDataSource.getDashboardData();
    try{
      return Right(result);
    }on ServerFailure catch(failure){
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, BaseTaskData>> sendTaskData(TaskParameter parameter) async{
    final result=await baseRemoteDataSource.sendTaskData(parameter);
    try{
      return Right(result);
    }on ServerFailure catch(failure){
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, BaseTaskData>> updateTaskData(TaskParameter parameter) async{
    final result=await baseRemoteDataSource.updateTaskData(parameter);
    try{
      return Right(result);
    }on ServerFailure catch(failure){
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, BaseTaskData>> getTaskData(StatusParameter parameter)async {
    final result=await baseRemoteDataSource.getTaskData(parameter);
    try{
      print(result);
      return Right(result);
    }on ServerFailure catch(failure){
      return Left(ServerFailure(failure.message));
    }
  }

}