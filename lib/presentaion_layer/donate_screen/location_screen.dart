import 'package:blood_test/controller/map_controller.dart';
import 'package:blood_test/controller/user_controller.dart';
import 'package:blood_test/presentaion_layer/resources/button_manger/my_button.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../shared/utils/utils.dart';
import '../login_screen/login_screen.dart';
import '../resources/color_ manger/color_manger.dart';
import '../welcome_screen/welcome_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.email, this.phoneNumber, this.dateOfBirth, this.gender, this.lastName, this.firstName,required this.isDonate});
  final String ?firstName;
  final String ?lastName;
  final String ?phoneNumber;
  final String ?dateOfBirth;
  final String ?email;
  final String ?gender;
  final bool isDonate;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _mapController=Get.find<MapController>(tag: 'map_controller');
  final _userController=Get.find<UserController>(tag: 'user_controller');
  final _lat=TextEditingController();
  final _long=TextEditingController();
  bool isYes=true;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
        backgroundColor: ColorManger.kSecoundry,
        title:const Text(
          'Location Screen',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20

          ),
        ),
        actions: [
          IconButton(onPressed: (){
            Get.offAll(()=>const LoginScreen());
          }, icon:const Icon(Icons.logout,color: Colors.white,))
        ],
      ),
      body: SingleChildScrollView(
        padding:const EdgeInsetsDirectional.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20),
                color: Colors.grey[300]
              ),
              child: GoogleMap(
                  initialCameraPosition: CameraPosition(target: LatLng(_mapController.myPosition!.latitude,_mapController.myPosition!.longitude),zoom: 14),
                myLocationEnabled: true,

              ) ,
            ),
            const SizedBox(
              height: 20,
            ),
           const Text(
              'Take Your Current Location ?',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      if(isYes){

                      }
                      else{
                        isYes=!isYes;
                        setState(() {

                        });
                      }
                    },
                    child: Container(
                      height: 200,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20),
                          color: isYes?ColorManger.kSecoundry:Colors.white,
                        border: Border.all(
                          color: ColorManger.kSecoundry
                        )
                      ),
                      child: Text(
                        'Yes',
                          style: TextStyle(
                              color: isYes?Colors.white:ColorManger.kSecoundry,
                              fontWeight: FontWeight.bold,
                              fontSize: 30
                          )
                      ),
                    ),
                  ),

                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      if(isYes){
                        isYes=!isYes;
                      }
                      setState(() {

                      });
                    },
                    child: Container(
                      height: 200,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20),
                          color: isYes?Colors.white:ColorManger.kSecoundry,
                          border: Border.all(
                              color: ColorManger.kSecoundry
                          )
                      ),
                      child:
                      Text('No',style:
                      TextStyle(
                        color: isYes?ColorManger.kSecoundry:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),),

                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if(!isYes)...[
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _lat,
                decoration:const InputDecoration(
                  // border: InputBorder.none,
                  labelText: 'Lattiude',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              TextFormField(
                keyboardType: TextInputType.number,
                controller: _long,
                decoration:const InputDecoration(
                  // border: InputBorder.none,
                  labelText: 'Longttude',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],

            Obx(()=>ConditionalBuilder(
                condition: _userController.isLoading,
                builder: (context)=>const Center(child: CircularProgressIndicator(color: ColorManger.kSecoundry,)),
                fallback: (context)=>myButton(title: 'submit'.toUpperCase(), onTap: ()async{
                  if(isYes){
                    if(widget.isDonate){
                      final result= await _userController.sendDonateRequest(
                          firstName: widget.firstName??'',
                          lastName: widget.lastName??'',
                          gender: widget.gender??'',
                          dateOfBirth: widget.dateOfBirth??'',
                          phoneNumber: widget.phoneNumber??'',
                          lat: _mapController.myPosition!.latitude.toString(),
                          long: _mapController.myPosition!.longitude.toString(),
                          email: widget.email??'');
                      if(result){
                        Utils.myToast(title: 'Process Success');
                        Get.offAll(()=>const WelcomeScreen());

                      }else{
                        Utils.myToast(title: 'The Process Failed ! ');
                      }
                    }
                    else{
                      final result=await _userController.sendNeedBloodRequest(lat: _mapController.myPosition!.latitude.toString(), long: _mapController.myPosition!.longitude.toString());
                      if(result){
                        Utils.myToast(title: 'Process Success');
                        Get.offAll(()=>const WelcomeScreen());
                      }else{
                        Utils.myToast(title: 'The Process Failed ! ');


                      }
                    }
                  }else{
                    if(_lat.text.isNotEmpty&&_long.text.isNotEmpty){
                      if(widget.isDonate){
                        final result= await _userController.sendDonateRequest(
                            firstName: widget.firstName??'',
                            lastName: widget.lastName??'',
                            gender: widget.gender??'',
                            dateOfBirth: widget.dateOfBirth??'',
                            phoneNumber: widget.phoneNumber??'',
                            lat: _lat.text,
                            long: _long.text,
                            email: widget.email??'');
                        if(result){
                          Utils.myToast(title: 'Process Success');
                          Get.offAll(()=>const WelcomeScreen());

                        }else{
                          Utils.myToast(title: 'The Process Failed ! ');
                        }
                      }
                      else{
                        final result=await _userController.sendNeedBloodRequest(lat:_lat.text, long: _long.text);
                        if(result){
                          Utils.myToast(title: 'Process Success');
                          Get.offAll(()=>const WelcomeScreen());
                        }else{
                          Utils.myToast(title: 'The Process Failed ! ');


                        }
                      }
                    }else{
                      Utils.myToast(title: 'Please Enter The Latitiude and Longtitude');
                    }


                  }

                })))

          ],
        ),
      ),

    );
  }

}

