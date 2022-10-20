import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:task_app/core/utils/enum.dart';
import 'package:task_app/domain/use_case/get_all_tasks_use_case.dart';
import 'package:task_app/presentation/controller/home/home_state.dart';
import 'package:task_app/presentation/screens/component/compenent.dart';

import '../../core/services/cach_helper.dart';
import '../../core/services/service_locator.dart';
import '../../core/utils/constrant.dart';
import '../controller/home/home_bloc.dart';
import '../controller/home/home_event.dart';
import 'component/tasts_data_component.dart';
import 'component/add_task_screen.dart';
import 'component/dash_board_component.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
List<String> strings=[
  "All Tasks",
  "in_progress",
  "new",
  "completed",
  "outdated"
];

String status='';

  @override
  Widget build(BuildContext context) {
    uId ??= CachHelper.getData(key: "uId");

    return BlocProvider(
        create: (context)=>sl<HomeBloc>(),
      child: BlocConsumer<HomeBloc,HomeState>(
        builder: (context,state){

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  const DashBoardComponent(),
                   ListTile(
                     title: Row(
                       children: [
                         Icon(Icons.task_alt),
                         SizedBox(width: 8,),
                         Text(
                             "All Tasks",
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 18
                           ),
                         ),
                       ],
                     ),
                     onTap: (){
                      navigateTo(context,  TasksDataComponent(status:  '',));
                     },
                   ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.cloud_upload_sharp),
                        SizedBox(width: 8,),
                        Text(
                          "In Progress",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                      ],
                    ),
                    onTap: (){

                      navigateTo(context, TasksDataComponent(status:'in_progress',));
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.new_releases_sharp),
                        SizedBox(width: 8,),
                        Text(
                          "New Tasks",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                      ],
                    ),
                    onTap: (){

                      navigateTo(context,  TasksDataComponent(status:  'new',));
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.done),
                        SizedBox(width: 8,),
                        Text(
                          "Completed Tasks",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                      ],
                    ),
                    onTap: (){
                      navigateTo(context,  TasksDataComponent(status:  'completed',));
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.content_paste_off),
                        SizedBox(width: 8,),
                        Text(
                          "Outdated Tasks",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                      ],
                    ),
                    onTap: (){
                      navigateTo(context,  TasksDataComponent(status:'outdated',));
                    },
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                navigateTo(context, AddTaskScreen());
              },
              child: const Icon(Icons.add),
            ),
          );
        },
        listener: (context,state){
          if(state.tasksDataState !=RequestState.loading){
            HomeState(tasksDataState: RequestState.loading,tasksData:const []);
          }
        },
      ),
    );
  }
}
