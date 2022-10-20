import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/enum.dart';
import '../../controller/home/home_bloc.dart';
import '../../controller/home/home_event.dart';
import '../../controller/home/home_state.dart';
class DashBoardComponent extends StatelessWidget {
  const DashBoardComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context)=>sl<HomeBloc>()..add(GetDashboardDataEvent()),
      child: BlocBuilder<HomeBloc,HomeState>(
        builder: (context,state){
          switch(state.dashboardDataState){
            case RequestState.loading:
              return const Center(child: CircularProgressIndicator());
            case RequestState.loaded:
              var dashboardData=state.dashboardData;
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.shade500
                  ),
                  child: Row(
                    children: [
                      CircularPercentIndicator(
                        radius: 90.0,
                        lineWidth: 9.0,
                        circularStrokeCap: CircularStrokeCap.round,
                        percent:dashboardData!.completedTasks/dashboardData.allTasks,
                        animation: true,
                        animationDuration: 2000,
                        center: CircularPercentIndicator(
                          radius: 70.0,
                          lineWidth: 9.0,
                          circularStrokeCap: CircularStrokeCap.round,
                          animation: true,
                          animationDuration: 2000,
                          percent:dashboardData.inProgressTasks/dashboardData.allTasks,
                          center: CircularPercentIndicator(
                            radius: 50.0,
                            lineWidth: 9.0,
                            circularStrokeCap: CircularStrokeCap.round,
                            animation: true,
                            animationDuration: 2000,
                            center: Text(
                                "${dashboardData.allTasks}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                            ),
                            percent: dashboardData.outdatedTasks/dashboardData.allTasks,
                            progressColor: Colors.redAccent,
                          ),
                          progressColor: const Color(0xff000ffb),
                        ),
                        progressColor: Colors.amber,
                      ),
                      SizedBox(
                        width: width*0.01
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.amber,
                                ),
                               const  SizedBox(width:4 ,),
                                const Text(
                                    "Completed",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                  ),
                                ),
                                 Spacer(),
                                Text('${((dashboardData.completedTasks/dashboardData.allTasks)*100).round()}%')
                              ],
                            ),
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: const Color(0xff000ffb),
                                ),
                                SizedBox(width:4 ,),

                                Text("In Progress",
                                  style:  TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14
                                    )),
                                Spacer(),
                                Text('${((dashboardData.inProgressTasks/dashboardData.allTasks)*100).round()}%')
                              ],
                            ),
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.redAccent,
                                ),
                                SizedBox(width:4 ,),
                                Text(
                                    "Outdated",
                                    style:  TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14
                                    )
                                ),
                                Spacer(),
                                Text('${((dashboardData.outdatedTasks/dashboardData.allTasks)*100).round()}%')
                              ],
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                        ],
                      )

                    ],
                  ),
                ),
              );
            case RequestState.error:
              return Center(child: Text(state.dashboardDataMessage),);
          }
        },
      ),
    );

  }
}
