import 'package:flutter/material.dart';
import 'package:task_app/core/services/cach_helper.dart';
import 'package:task_app/core/services/dio_helper.dart';
import 'package:task_app/core/services/service_locator.dart';
import 'package:task_app/presentation/screens/home_screen.dart';
import 'package:task_app/presentation/screens/on_boarding_screen/on_boading_screen.dart';
import 'package:task_app/presentation/screens/register/login_screen.dart';

import 'core/utils/app_color.dart';
import 'core/utils/constrant.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CachHelper.init();
  ServicesLocator().init();


  uId=CachHelper.getData(key: "uId");
  Widget widget;
  if(uId!=null){
    widget=HomeScreen();
  }else{
    widget=const OnBoardingScreen();
  }
  runApp(  MyApp(startWidget: UserLoginScreen() ,));
}

class MyApp extends StatelessWidget {
final Widget startWidget;

  const MyApp({
    super.key,
    required this.startWidget
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
              color: lightIconsColor
          ),
          backgroundColor: lightScaffoldColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: mainColor,fontSize: 22,fontWeight: FontWeight.bold
          ),


        ),
      ),
      home: startWidget,
    );
  }
}


