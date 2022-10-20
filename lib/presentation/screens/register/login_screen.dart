import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/core/services/cach_helper.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/app_color.dart';
import '../../controller/register/register_bloc.dart';
import '../../controller/register/register_event.dart';
import '../../controller/register/register_state.dart';
import '../component/compenent.dart';
import '../home_screen.dart';



class UserLoginScreen extends StatelessWidget {
  UserLoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();


    var passwordController = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context)=>sl<RegisterBloc>(),
      child: BlocConsumer<RegisterBloc,RegisterState>(
          builder: (context,state){
            return Scaffold(
              body: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height*0.02,),
                        SizedBox(height: height*0.1,),
                        Text(
                          'Login to your account',
                          style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.black),
                        ),
                        Text(
                          'Lets Login to Communicate With Your Friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: height*0.02,),
                        TextFormField(
                            controller: emailController,
                            style:const TextStyle(
                                color: Colors.black
                            ),
                            decoration: InputDecoration(
                                labelText: "Email",
                                hintStyle: const TextStyle(
                                    color: Colors.black
                                ),
                                labelStyle: const TextStyle(
                                    color: Colors.black
                                ),
                                prefixIcon:const  Icon(
                                  Icons.email,
                                ),
                                enabledBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:  BorderSide(
                                      color: mainColor,

                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: mainColor  ,

                                    )
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,

                                    )
                                )
                            )

                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            controller: passwordController,
                            style:const TextStyle(
                                color: Colors.black
                            ),
                            decoration: InputDecoration(
                                labelText: "Password",
                                hintStyle: const TextStyle(
                                    color: Colors.black
                                ),
                                labelStyle: const TextStyle(
                                    color: Colors.black
                                ),
                                prefixIcon:const  Icon(
                                  Icons.lock,
                                ),
                                enabledBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: mainColor,

                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: mainColor  ,

                                    )
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,

                                    )
                                )
                            )

                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(height: height*0.1,),
                        defaultButton(function: () {
                          if(formKey.currentState!.validate()){
                            sl<RegisterBloc>().add(
                                UserLoginEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ));


                            // navigateTo(context,  HomeScreen());
                          }
                        }, text: 'Login'),


                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        listener: (context,state){
            print(state.userAccessToken);
          if(state.userAccessToken!=null){
            CachHelper.saveData(key: "uId", value: state.userAccessToken!.token)
                .then((value) {
              navigateTo(context,  HomeScreen());
            });

          }
        },
      ),

    );
  }
}
