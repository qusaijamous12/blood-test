import 'package:blood_test/model/user_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/map_controller.dart';
import '../../controller/user_controller.dart';
import '../resources/color_ manger/color_manger.dart';
import 'chat_screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _userController=Get.find<UserController>(tag: 'user_controller');
  final _mapController=Get.find<MapController>(tag: 'map_controller');
  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await _userController.getAllUsersAdmin();
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
          'Chat Screen',
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
                  if(_userController.listUsers.isEmpty){
                    return const Center(
                      child: Text(
                        'There is No Users ',
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
                        itemBuilder: (context,index)=>buildUsersItem(_userController.listUsers[index]),
                        separatorBuilder: (context,index)=>const SizedBox(
                          height: 15,
                        ),
                        itemCount: _userController.listUsers.length);
                  }
                }))


          ],
        ),
      ),
    );
  }
  Widget buildUsersItem(UserModel model)=>  GestureDetector(
    onTap: (){
      Get.to(()=> ChatScreen(recieverId:model.uid!));
    },
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
          color: Colors.white
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFDkr6lk7zlXhGwUlQeFWFKsXfB6W0lUjQOg&s'),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            '${model.name}',
            style:const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ) ,
          const Spacer(),
         const Icon(Icons.arrow_forward_ios,color: ColorManger.kSecoundry,)
        ],
      ),
    ),
  );


}
