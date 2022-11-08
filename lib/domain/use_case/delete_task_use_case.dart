import 'package:dartz/dartz.dart';
import 'package:task_app/core/error/failure.dart';
import 'package:task_app/core/use_case/base_use_case.dart';
import 'package:task_app/domain/repo/base_app_repo.dart';

import '../../core/utils/constrant.dart';

class DeleteTaskUseCase extends BaseUseCase<void,StatusParameter>{
  final BaseAppRepository baseAppRepository;


  DeleteTaskUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, void>> call(StatusParameter parameter)async {
   return await baseAppRepository.deleterTask(parameter);
  }

}