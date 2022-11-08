import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/enum.dart';
import '../../controller/home/home_bloc.dart';
import '../../controller/home/home_event.dart';
import '../../controller/home/home_state.dart';
import 'compenent.dart';

class TaskDetailsScreen extends StatelessWidget {
  final int taskId;

  TaskDetailsScreen({
    Key? key,
    required this.taskId
  }) : super(key: key);

  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  var startDateController = TextEditingController();

  var endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    print(taskId);
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return BlocProvider.value(
      value: sl<HomeBloc>()..add(GetTaskDataEvent(id: taskId)),
      child: BlocConsumer<HomeBloc, HomeState>(
          builder: (context, state) {

            switch(state.taskDataState){
              case RequestState.loading:
                return const Center(child: CircularProgressIndicator());
              case RequestState.loaded:
                titleController.text=state.taskData!.title;
                descriptionController.text=state.taskData!.description;
                startDateController.text=state.taskData!.startDate;
                endDateController.text=state.taskData!.endDate;
                print("Task Image ${state.taskData!.image}");
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Task Data"),
                    actions: [
                      defaultTextButton(text: 'Update', pressedFunction: (){
                        sl<HomeBloc>().add(UpdateTaskDataEvent(
                            taskId: taskId,
                            title: titleController.text,
                            description: descriptionController.text,
                            imagePath: state.image!.path==''?state.taskData!.image:state.image!.path,
                            imageName: state.taskData!.title,
                            startDate: startDateController.text,
                            endDate: endDateController.text));
                      }),
                      defaultTextButton(text: 'Delete', pressedFunction: (){
                        sl<HomeBloc>().add(DeleteTaskDataEvent(id: taskId));
                      })
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Center(
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                 CircleAvatar(
                                  radius: 50,
                                  backgroundImage: state.taskData!.image!=''?NetworkImage("https://tasks.eraasoft.com/${state.taskData!.image}"):const NetworkImage('https://img.icons8.com/ios-filled/512/no-image.png') ,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: IconButton(
                                    onPressed: () {
                                      sl<HomeBloc>().add(GetImageFromGalleryEvent());
                                    }, icon: const Icon(Icons.image, size: 32,),
                                    color: Colors.blue,

                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.1,),

                          defaultFormField(
                              controller: titleController,
                              type: TextInputType.text,

                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Title must not be empty';
                                }
                                return null;
                              },
                              label: "Title",
                              prefixIcon: Icons.title),
                          SizedBox(height: height * 0.01,),
                          defaultFormField(
                              controller: descriptionController,
                              type: TextInputType.text,
                              label: "Description",
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Description must not be empty';
                                }
                                return null;
                              },
                              prefixIcon: Icons.description),
                          SizedBox(height: height * 0.01,),
                          defaultFormField(
                              controller: startDateController,
                              type: TextInputType.none,
                              onTap: () {
                                showDatePicker(
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2050),
                                  context: context,
                                ).then((value) {
                                  startDateController.text =
                                  value.toString().split(' ')[0];
                                });
                              },
                              label: "Start Date",
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Start Date must not be empty';
                                }
                                return null;
                              },
                              prefixIcon: Icons.date_range),
                          SizedBox(height: height * 0.01,),

                          defaultFormField(
                              controller: endDateController,
                              type: TextInputType.none,
                              onTap: () {
                                showDatePicker(
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2050), context: context,
                                ).then((value) {
                                  endDateController.text = value.toString().split(' ')[0];
                                });
                              },
                              label: "End Date",
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'End Date must not be empty';
                                }
                                return null;
                              },
                              prefixIcon: Icons.date_range),
                          SizedBox(height: height * 0.1,),




                        ],
                      ),
                    ),
                  ),
                );
              case RequestState.error:
                return Center(child: Text(state.taskDataMessage));
            }
          },
          listener: (context, state) {
        if(state.updateTaskState==RequestState.loaded) {
          Navigator.pop(context);
          showToast(text: "Task Update Successfully", state: ToastStates.SUCCESS);
        }
        if(state.deleteTaskDataState==RequestState.loaded) {
          showToast(text: "Task Deleted Successfully", state: ToastStates.SUCCESS);
          Navigator.pop(context);

        }
      }),
    );
  }
}
