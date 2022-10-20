import 'package:dartz/dartz.dart';
import 'package:task_app/domain/entities/base_auth_data.dart';

import '../../core/error/failure.dart';
import '../../core/use_case/base_use_case.dart';
import '../../core/utils/constrant.dart';
import '../repo/base_app_repo.dart';

class UserSignInUseCase extends BaseUseCase<BaseAuthData,UserParameter>{
  final BaseAppRepository baseAppRepository;

  UserSignInUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, BaseAuthData>> call(UserParameter parameter)async {
    return await baseAppRepository.userSignIn(parameter);
  }


}