import 'package:dartz/dartz.dart';
import 'package:task_app/core/error/failure.dart';
import 'package:task_app/core/use_case/base_use_case.dart';
import 'package:task_app/domain/entities/base_dash_board_data.dart';
import 'package:task_app/domain/repo/base_app_repo.dart';

class GetDashboardDataUseCase extends BaseUseCase<BaseDashboardData,NoParameters>{
  final BaseAppRepository baseAppRepository;

  GetDashboardDataUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, BaseDashboardData>> call(NoParameters parameter) async{
    return await baseAppRepository.getDashboardData();
  }
}