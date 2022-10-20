import 'package:task_app/core/utils/app_color.dart';
import 'package:task_app/presentation/screens/component/compenent.dart';

import '../../../domain/entities/base_slider_object.dart';
import 'package:flutter/material.dart';

import '../register/login_screen.dart';
import '../register/resgisteration_screen.dart';
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

   List<BaseSliderObject> sliderObject=[
     BaseSliderObject(
         "Manage Your Task",
         "Plan,schedule your Tasks and meets all targets easily",
         "assets/images/tasks.png"),
     BaseSliderObject(
         "Manage Your Time",
         "Control of time spent on activities, to increase effectiveness, efficiency and productivity",
         "assets/images/schedule.png"),
     BaseSliderObject(
         "Track your Progress",
         "Increase your ability to success",
         "assets/images/target.png"),
   ];
   final PageController _controller=PageController();
   int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height*0.2,),
              Expanded(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                    onPageChanged: (index){
                    setState(() {
                      currentIndex=index;
                    });
                    },
                    itemCount: sliderObject.length,
                    itemBuilder:  (context,index)=>buildBodyItem(sliderObject[index])
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(sliderObject.length, (index) => buildDot(index, context),
                  ),
                ),
              ),
              defaultButton(function: (){
                navigateTo(context,  RegisterationScreen());
              }, text: "sign Up"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  const Text("Already have an account?"),
                  defaultTextButton(
                      text: "login",
                      color: mainColor,
                      pressedFunction: (){
                        navigateTo(context, UserLoginScreen());
                  })
                ],
              )

            ],
          ),
        ),
      ) ,
    );
  }

  Widget buildDot(int index,context)=>Container(
    height: 10,
    width: currentIndex==index?25:10,
    margin:const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.green
    ),

  );

  Widget buildBodyItem(BaseSliderObject model){
    return Column(
      children: [
        Image.asset(model.image),
        const SizedBox(height: 20,),
        Text(
            model.title,
          style:const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        const SizedBox(height: 20,),
        Text(
          model.subTitle,
          style:const TextStyle(
              fontSize: 12,
              color: Colors.grey
          ),
        ),
      ],
    );
  }
}


