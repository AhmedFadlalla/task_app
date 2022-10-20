import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:task_app/presentation/controller/register/register_event.dart';
import 'package:task_app/presentation/controller/register/register_state.dart';


import '../../../core/utils/constrant.dart';
import '../../../core/utils/enum.dart';
import '../../../domain/use_case/user_sign_in_use_case.dart';
import '../../../domain/use_case/user_sign_up_use_case.dart';



class RegisterBloc extends Bloc<BaseRegisterEvent, RegisterState> {
  final UserSignUpUseCase userSignUpUseCase;
  final UserSignInUseCase userSignInUseCase;
  RegisterBloc(this.userSignUpUseCase,this.userSignInUseCase) : super(RegisterState()) {
    on<UserRegisterEvent>((event, emit) async{
      final result=await userSignUpUseCase(UserParameter(

        email: event.email,
        password: event.password,
        name: event.name,));

      result.fold((l) => emit(
          state.copyWith(
              userRegisterState: RequestState.error,
              userRegisterMessage: l.message
          )
      ), (r) => emit(
          state.copyWith(
              userRegisterState: RequestState.loaded
          )
      ));
    });
    on<UserLoginEvent>((event, emit) async{
      final result=await userSignInUseCase(UserParameter(
        email: event.email,
        password: event.password, name: '',
      ));

      result.fold((l) => emit(
          state.copyWith(
              userLoginState: RequestState.error,
              userLoginMessage: l.message
          )
      ), (r) => emit(
          state.copyWith(
              userLoginState: RequestState.loaded,
              userAccessToken: r
          )
      ));
    });



  }
}
