import 'package:blood_test/shared/utils/utils.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import '../resources/button_manger/my_button.dart';
import '../resources/color_ manger/color_manger.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final _otpController=TextEditingController();

  final _userController=Get.find<UserController>(tag: 'user_controller');

  @override
  void initState() {

    Future.delayed(Duration.zero,()async{
      await _userController.sumbitPhoneNumber(phoneNumber: _userController.userModel.phone!);
    });

    super.initState();
  }
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
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  controller: _otpController,
                  decoration:const InputDecoration(
                    // border: InputBorder.none,
                    labelText: 'Otp Code',
                    prefixIcon: Icon(Icons.qr_code_2),
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
                          if(_otpController.text.isNotEmpty){
                            await  _userController.sumbitOTP(otpCode: _otpController.text);
                          }
                          else{
                            Utils.myToast(title: 'Please Enter Otp Code');
                          }

                        }))),




              ],

            ),
          ),
        ),
      ),
    );
  }
}
