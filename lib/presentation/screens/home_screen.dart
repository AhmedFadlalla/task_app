import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:task_app/core/utils/enum.dart';
import 'package:task_app/domain/use_case/get_all_tasks_use_case.dart';
import 'package:task_app/presentation/controller/home/home_state.dart';
import 'package:task_app/presentation/screens/component/category_component.dart';
import 'package:task_app/presentation/screens/component/compenent.dart';

import '../../core/services/cach_helper.dart';
import '../../core/services/service_locator.dart';
import '../../core/utils/constrant.dart';
import '../controller/home/home_bloc.dart';
import '../controller/home/home_event.dart';
import 'component/tasts_data_component.dart';
import 'component/add_task_screen.dart';
import 'component/dash_board_component.dart';

class HomeScreen extends StatelessWidget {
   String? token;

   HomeScreen({Key? key,this.token}) : super(key: key);

String status='';

  @override
  Widget build(BuildContext context) {
    uId ??= CachHelper.getData(key: "uId");

    return BlocProvider(
        create: (context)=>sl<HomeBloc>(),
      child: BlocBuilder<HomeBloc,HomeState>(
        builder: (context,state){

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                   DashBoardComponent(token: (uId ?? token)!),
                  const SizedBox(height: 25,),
                  CategoryComponent(),

                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                navigateTo(context, AddTaskScreen(onStop: (value){}));
              },
              child: const Icon(Icons.add),
            ),
          );
        },

      ),
    );
  }
}
