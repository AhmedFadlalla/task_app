import 'package:dartz/dartz.dart';
import 'package:task_app/core/error/failure.dart';
import 'package:task_app/core/use_case/base_use_case.dart';
import 'package:task_app/core/utils/constrant.dart';
import 'package:task_app/domain/repo/base_app_repo.dart';

class UserSignUpUseCase extends BaseUseCase<void,UserParameter>{
  final BaseAppRepository baseAppRepository;

  UserSignUpUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, void>> call(UserParameter parameter)async {
    return await baseAppRepository.userSignUp(parameter);
  }


}