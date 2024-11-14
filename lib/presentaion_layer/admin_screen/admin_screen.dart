import 'package:blood_test/presentaion_layer/admin_screen/deliver_screen.dart';
import 'package:blood_test/presentaion_layer/admin_screen/users_screen.dart';
import 'package:blood_test/presentaion_layer/user_screen/user_screen.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import '../resources/color_ manger/color_manger.dart';
import '../user_screen/history_screen.dart';
import '../user_screen/profile_screen.dart';
import 'history_admin_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _userController=Get.find<UserController>(tag: 'user_controller');
  final controller=CarouselSliderController();
  final ss=PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManger.kSecoundry,
        title:const Text(
          'Home Screen',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20

          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFDkr6lk7zlXhGwUlQeFWFKsXfB6W0lUjQOg&s'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  ' Hello ${_userController.userModel.name}',
                  style:const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                )
              ],

            ),
            const SizedBox(
              height: 20,
            ),
            CarouselSlider(
                carouselController:controller ,

                items: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20)
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child:const Image(image: NetworkImage('https://static.vecteezy.com/system/resources/previews/008/191/708/non_2x/human-blood-donate-and-heart-rate-on-white-background-free-vector.jpg'),fit: BoxFit.fill,)),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20)
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child:const Image(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ_x-w14YiwYXVL-lT9KcJ8QqaUXAy4ud2wA&s'),fit: BoxFit.fill,)),

                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20)
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child:const Image(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGs5AmpIpHvw71kecJ_iyJuZgY6QiDksuLeEPrxyREsNW23BBn6Hzdw2YeSIXCJ9Bag4o&usqp=CAU'),fit: BoxFit.fill,)),

                ],
                options: CarouselOptions(
                    height: 250,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval:const Duration(seconds: 3),
                    autoPlayAnimationDuration:const Duration(seconds: 1),
                    autoPlayCurve: Curves.easeInExpo,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1 // we use it to solve the problem of images that occuer when we dont use it try to put insted of 1 0.4 and you will see the problem
                )),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.to(()=>const HistoryAdminScreen());


                    },
                    child: Container(
                      height: 200,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey.shade500
                          )
                      ),
                      child:const Icon(Icons.bloodtype,size: 150,color: ColorManger.kSecoundry,),
                    ),
                  ),

                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.to(()=>const UsersScreen());

                    },
                    child: Container(
                        height: 200,
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.grey.shade500
                            )
                        ),
                        child:const Icon(Icons.chat,size: 150,color: ColorManger.kSecoundry,)

                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: (){
                Get.to(()=>const DeliverScreen());
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.all(10),
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey.shade500
                    ),
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: Colors.white
                ),
                child:const Row(
                  children: [
                    Icon(Icons.delivery_dining,color: ColorManger.kSecoundry,size: 30,),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Delivery',
                      style: TextStyle(
                          color: ColorManger.kSecoundry,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,color: ColorManger.kSecoundry,)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: (){
                Get.to(()=>const ProfileScreen());
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.all(10),
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey.shade500
                    ),
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: Colors.white
                ),
                child:const Row(
                  children: [
                    Icon(Icons.person_outline_sharp,color: ColorManger.kSecoundry,size: 30,),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'My Profile',
                      style: TextStyle(
                          color: ColorManger.kSecoundry,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,color: ColorManger.kSecoundry,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
