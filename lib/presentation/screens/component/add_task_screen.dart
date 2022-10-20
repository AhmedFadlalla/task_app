import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/utils/enum.dart';
import 'package:task_app/presentation/controller/home/home_bloc.dart';
import 'package:task_app/presentation/controller/home/home_state.dart';
import 'package:task_app/presentation/screens/component/compenent.dart';
import 'package:task_app/presentation/screens/home_screen.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/app_color.dart';
import '../../controller/home/home_event.dart';

class AddTaskScreen extends StatelessWidget {
   AddTaskScreen({Key? key}) : super(key: key);

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;

    return BlocProvider(
      create: (context) => sl<HomeBloc>(),
      child: BlocConsumer<HomeBloc, HomeState>(
          builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Add Task"),
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
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600"
                          ),
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

                  defaultButton(text: 'Save Task', function: () {
                    sl<HomeBloc>().add(
                        SendTaskDataEvent(title: titleController.text,
                            description: descriptionController.text,
                            imagePath: state.image!.path,
                            imageName: state.image!.name,
                            startDate: startDateController.text,
                            endDate: endDateController.text));
                  })


                ],
              ),
            ),
          ),
        );
      }, listener: (context, state) {
        if(state.sendTaskState==RequestState.loaded) {
          Navigator.pop(context);
          showToast(text: "Task Sent Successfully", state: ToastStates.SUCCESS);
        }
      }),
    );
  }
}
