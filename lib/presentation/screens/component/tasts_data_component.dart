import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/domain/entities/base_task_data.dart';
import 'package:task_app/presentation/screens/component/compenent.dart';
import 'package:task_app/presentation/screens/component/task_details_screen.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/enum.dart';
import '../../controller/home/home_bloc.dart';
import '../../controller/home/home_event.dart';
import '../../controller/home/home_state.dart';

class TasksDataComponent extends StatelessWidget {
  final String status;
   TasksDataComponent({
     Key? key,required this.status
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider.value(
      value: sl<HomeBloc>()..add(GetAllTasksDataEvent(name:status)),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch(state.tasksDataState){
            case RequestState.loading:
              return const Center(child: CircularProgressIndicator(),);
            case RequestState.loaded:
              var tasksData=state.tasksData;
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      status,
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                  ),
                  body:tasksData.isNotEmpty? Container(
                    child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index)=>buildItem(tasksData[index],context),
                        separatorBuilder: (context,index)=>myDivider(),
                        itemCount: state.tasksData.length),
                  ):const
                  Center(child: Text(
                      "No Tasks",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  )),
                );
            case RequestState.error:
              return  Center(child: Text(state.tasksDataMessage),);
          }
        },
      ),
    );
  }

  Widget buildItem(BaseTaskData data,context)=>GestureDetector(
    onTap: (){
      navigateTo(context, TaskDetailsScreen(taskId: data.id,));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                  data.startDate,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
              const SizedBox(height: 4,),
              Text(
                  data.endDate,
                style: const TextStyle(
                    fontSize: 12,
                  color: Colors.grey
                ),
              )
            ],
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: mainColor.withOpacity(0.2)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize:20
                      ),
                    ),
                    Text(
                      data.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w500,
                          fontSize:15
                      ),
                    ),
                    Text(
                      data.status,
                      style: const TextStyle(
                          fontSize: 19,
                          color: Colors.grey
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
