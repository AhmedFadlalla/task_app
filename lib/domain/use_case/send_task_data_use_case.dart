import 'package:dartz/dartz.dart';
import 'package:task_app/core/error/failure.dart';
import 'package:task_app/core/use_case/base_use_case.dart';
import 'package:task_app/core/utils/constrant.dart';
import 'package:task_app/domain/entities/base_task_data.dart';
import 'package:task_app/domain/repo/base_app_repo.dart';

class SendTaskDataUseCase extends BaseUseCase<BaseTaskData,TaskParameter>{
  final BaseAppRepository baseAppRepository;


  SendTaskDataUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, BaseTaskData>> call(TaskParameter parameter) async{
    return await baseAppRepository.sendTaskData(parameter);
  }

}