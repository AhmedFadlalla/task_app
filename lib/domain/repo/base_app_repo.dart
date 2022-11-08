import 'package:dartz/dartz.dart';
import 'package:task_app/core/utils/constrant.dart';
import 'package:task_app/domain/entities/base_dash_board_data.dart';
import 'package:task_app/domain/entities/base_task_data.dart';

import '../../core/error/failure.dart';
import '../entities/base_auth_data.dart';

abstract class BaseAppRepository {
  Future<Either<Failure, void>> userSignUp(UserParameter parameter);
  Future<Either<Failure, BaseAuthData>> userSignIn(UserParameter parameter);
  Future<Either<Failure, List<BaseTaskData>>> getTasksByStatus(StatusParameter parameter);

  Future<Either<Failure, BaseDashboardData>> getDashboardData(IdParameter parameter);
  Future<Either<Failure, BaseTaskData>> sendTaskData(TaskParameter parameter);
  Future<Either<Failure, BaseTaskData>> updateTaskData(TaskParameter parameter);
  Future<Either<Failure, BaseTaskData>> getTaskData(StatusParameter parameter);
  Future<Either<Failure, void>> deleterTask(StatusParameter parameter);
}