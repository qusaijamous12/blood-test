import 'package:blood_test/presentaion_layer/register_screen/register_screen.dart';
import 'package:blood_test/shared/utils/utils.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import '../resources/button_manger/my_button.dart';
import '../resources/color_ manger/color_manger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  bool isObsecure=true;
  final _userController=Get.find<UserController>(tag: 'user_controller');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:const EdgeInsetsDirectional.all(20),
            child: Column(
              children: [
                Image.asset('assets/images/logo_new.png',height: 400,),
               const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: ColorManger.kSecoundry
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration:const InputDecoration(
                    // border: InputBorder.none,
                    labelText: 'Email Address',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _passwordController,
                  obscureText: isObsecure,

                  decoration: InputDecoration(
                    // border: InputBorder.none,
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: GestureDetector(
                          onTap: (){
                            isObsecure=!isObsecure;
                            setState(() {

                            });
                          },
                          child: Icon(isObsecure? Icons.visibility_off_outlined:Icons.visibility_outlined))
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: GestureDetector(
                    onTap: ()async{
                      if(_emailController.text.isEmpty){
                        Utils.myToast(title: 'Please Enter Your Email');
                      }else{
                        await  _userController.getUserDataBasedEmail(email: _emailController.text);

                      }

                    },
                    child: Text(
                      'Sign In With Phone Number',
                      style: TextStyle(
                        color:ColorManger.kSecoundry.withOpacity(0.6),
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Obx(()=>
                    ConditionalBuilder(
                        condition:_userController.isLoading ,
                        builder: (context)=>const Center(child: CircularProgressIndicator(color: ColorManger.kSecoundry,)),
                        fallback: (context)=> myButton(title: 'Login', onTap: ()async{
                          if(_emailController.text.isNotEmpty&&_passwordController.text.isNotEmpty){
                            await _userController.login(email: _emailController.text, password: _passwordController.text);

                          }
                          else{
                            Utils.myToast(title: 'Please Enter email and password');
                          }


                        }))),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account ?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    TextButton(
                        onPressed: (){
                          Get.offAll(()=>const RegisterScreen());
                        },
                        child:const Text(
                          'Register',
                          style: TextStyle(
                            color: ColorManger.kSecoundry,
                            fontSize: 18,
                            fontWeight: FontWeight.w900
                          ),
                        ))
                  ],
                )



              ],

            ),
          ),
        ),
      ),
    );
  }
}
