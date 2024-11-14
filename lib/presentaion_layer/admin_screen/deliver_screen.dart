import 'package:blood_test/controller/map_controller.dart';
import 'package:blood_test/controller/user_controller.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/history_model.dart';
import '../resources/button_manger/my_button.dart';
import '../resources/color_ manger/color_manger.dart';

class DeliverScreen extends StatefulWidget {
  const DeliverScreen({super.key});

  @override
  State<DeliverScreen> createState() => _DeliverScreenState();
}

class _DeliverScreenState extends State<DeliverScreen> {
  final _userController=Get.find<UserController>(tag: 'user_controller');
  final _mapController=Get.find<MapController>(tag: 'map_controller');

  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await _userController.getAllUserNeedBlood();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon:const Icon(Icons.arrow_back_ios,color:Colors.white)),
        backgroundColor: ColorManger.kSecoundry,
        title:const Text(
          'Delivery Screen',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20

          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.all(20),
        child: Column(
          children: [
            Obx(()=>ConditionalBuilder(
                condition: _userController.isLoading,
                builder: (context)=>const Center(child: CircularProgressIndicator(color: ColorManger.kSecoundry,)),
                fallback: (context){
                  if(_userController.historyAdminModel.isEmpty){
                    return const Center(
                      child: Text(
                        'There is No History ',
                        style: TextStyle(
                            color: ColorManger.kSecoundry,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    );
                  }
                  else{
                    return ListView.separated(
                        shrinkWrap: true,
                        physics:const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index)=>buildHistoryItem(_userController.historyNeedBlood[index]),
                        separatorBuilder: (context,index)=>const SizedBox(
                          height: 15,
                        ),
                        itemCount: _userController.historyNeedBlood.length);
                  }
                }))


          ],
        ),
      ),
    );
  }
  Widget buildHistoryItem(HistoryModel model)=>  Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(20),
        color: Colors.white
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Row(
      children: [
        const  Image(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOqSBDduwVY8GY-Mf8gvwqTWeEtyztoxFzaw&s'),height: 150,width: 150,fit: BoxFit.fill,),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Container(
            height: 200,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Name : ${model.firstName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),



                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Email :${model.email}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Text(
                        'Phone : ${model.phoneNumber}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),

                  ],
                ),
                const Spacer(),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    '${model.uid}',
                    style:const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                myButton(title: 'Location', onTap: ()async{

                  String googleMapsUrl = "https://www.google.com/maps/dir/?api=1&origin=${_mapController.myPosition!.latitude},${_mapController.myPosition!.longitude}&destination=${model.lattiude},${model.longtitude}";

                  if (await canLaunch(googleMapsUrl)) {
                    await launch(googleMapsUrl);
                  } else {

                    Get.snackbar("Error", "Couldn't open Google Maps", snackPosition: SnackPosition.BOTTOM);
                  }


                }),
                const SizedBox(
                  height: 15,
                ),

              ],
            ),
          ),
        )
      ],
    ),
  );

}
