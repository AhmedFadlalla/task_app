import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/presentation/controller/home/home_bloc.dart';
import 'package:task_app/presentation/controller/home/home_state.dart';
import 'package:task_app/presentation/screens/component/tasts_data_component.dart';

import '../../../core/services/service_locator.dart';
import 'package:flutter/material.dart';

import 'compenent.dart';
class CategoryComponent extends StatelessWidget {
   CategoryComponent({Key? key}) : super(key: key);

  List<IconData> icons=[
    Icons.task_alt,
    Icons.cloud_upload_sharp,
    Icons.new_releases_sharp,
    Icons.done,
    Icons.content_paste_off
  ];

  List<String> text=[
    'All Tasks',
    'In Progress Tasks',
    'New Tasks',
    'Completed Tasks',
    'Outdated Tasks'
  ];

  List<String> parameter=[
    '',
    'in_progress',
    'new',
    'completed',
    'outdated'
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>sl<HomeBloc>(),
      child: BlocBuilder<HomeBloc,HomeState>(
        builder: (context,state){
          return Container(
            child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index)=> ListTile(
                  title: Row(
                    children: [
                      Icon(icons[index]),
                      SizedBox(width: 8,),
                      Text(
                        text[index],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                    ],
                  ),
                  onTap: (){
                    navigateTo(context,  TasksDataComponent(status: parameter[index],));
                  },
                ),
                separatorBuilder: (context,index)=> myDivider(),
                itemCount: text.length),
          );
        },
      ),
    );
  }
}
