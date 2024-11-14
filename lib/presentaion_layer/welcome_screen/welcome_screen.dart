import 'package:blood_test/presentaion_layer/donate_screen/donate_screen.dart';
import 'package:blood_test/presentaion_layer/nedd_blood_screen/need_blood_screen.dart';
import 'package:blood_test/presentaion_layer/resources/button_manger/my_button.dart';
import 'package:blood_test/presentaion_layer/resources/color_%20manger/color_manger.dart';
import 'package:blood_test/presentaion_layer/user_screen/user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Spacer(),
              Image.asset('assets/images/logo_new.png'),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.off(()=>const NeedBloodScreen());
                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        height: 50,
                        decoration: BoxDecoration(
                            color: ColorManger.kSecoundry,
                            borderRadius: BorderRadiusDirectional.circular(20)
                        ),
                        child:const Text(
                          'Need blood',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.offAll(()=>const DonateScreen());

                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            color:Colors.white,
                          border: Border.all(
                            color: ColorManger.kPrimary
                          )
                        ),

                        child:const  Text(
                          'Donate',
                          style: TextStyle(
                              color: ColorManger.kSecoundry,
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(
                height:30 ,
              ),
              myButton(title: 'My Profile', onTap: (){
                Get.offAll(()=>const UserScreen());
              }),
              const Spacer(),



            ],
          ),
        ),
      ),
    );
  }
}
