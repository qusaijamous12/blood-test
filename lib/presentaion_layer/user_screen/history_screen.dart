import 'package:blood_test/controller/user_controller.dart';
import 'package:blood_test/model/history_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/color_ manger/color_manger.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _userController=Get.find<UserController>(tag: 'user_controller');
  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await _userController.getAllUserHistory();
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
        backgroundColor: ColorManger.kSecoundry,
        title:const Text(
          'History Screen',
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
                  if(_userController.historyModel.isEmpty){
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
                        itemBuilder: (context,index)=>buildHistoryItem(_userController.historyModel[index]),
                        separatorBuilder: (context,index)=>const SizedBox(
                          height: 15,
                        ),
                        itemCount: _userController.historyModel.length);
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
            height: 150,
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
                   const Spacer(),
                    Expanded(
                      child: Text(
                        'Gender : ${model.gender}',
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
                  height: 5,
                ),

              ],
            ),
          ),
        )
      ],
    ),
  );
}
