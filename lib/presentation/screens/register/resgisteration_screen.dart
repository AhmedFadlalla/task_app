import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/presentation/screens/register/login_screen.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/enum.dart';
import '../../controller/register/register_bloc.dart';
import '../../controller/register/register_event.dart';
import '../../controller/register/register_state.dart';
import 'package:google_fonts/google_fonts.dart';

import '../component/compenent.dart';
class RegisterationScreen extends StatelessWidget {
   RegisterationScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
   var nameController = TextEditingController();
   var emailController = TextEditingController();
   String emailLabel = 'E-Mail';

   var passwordController = TextEditingController();
   String passwordLabel = 'Password';

   var phoneController = TextEditingController();
   String phoneLabel = 'Phone';
  @override
  Widget build(BuildContext context) {


    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context)=>sl<RegisterBloc>(),
      child: BlocBuilder<RegisterBloc,RegisterState>(
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: const Text("Tasks"),
            ),
            body:  SingleChildScrollView(
              child: Center(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: height*0.06,),
                        Text(
                          'Create your account',
                          style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        SizedBox(height: height*0.05,),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Name must not be empty';
                              }
                            },
                            label: 'Name',
                            prefixIcon: Icons.person),
                        SizedBox(height: height*0.03,),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Email address must not be empty';
                              }
                              return null;
                            },
                            label: emailLabel,
                            prefixIcon: Icons.email_outlined),
                        SizedBox(height: height*0.03,),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Password must not be empty';
                              }
                              return null;
                            },
                            label: passwordLabel,
                            prefixIcon: Icons.lock),
                        SizedBox(height: height*0.22,),
                        state.userRegisterState==RequestState.loading?defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                sl<RegisterBloc>().add(
                                    UserRegisterEvent(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,));
                              }
                            },
                            text: 'Sign Up'):const Center(child: CircularProgressIndicator(),),
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
