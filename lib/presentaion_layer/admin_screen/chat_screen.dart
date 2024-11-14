import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../controller/user_controller.dart';
import '../../model/message_model.dart';
import '../../shared/utils/utils.dart';
import '../resources/color_ manger/color_manger.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key,required this.recieverId});
  final String recieverId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _userController=Get.find<UserController>(tag: 'user_controller');
  @override


  final _messageController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(

      builder: (BuildContext context) {
        _userController.getMessages(receiverId: widget.recieverId);


        return Obx(()=>LoadingOverlay(
            isLoading: false,
            child: Scaffold(
              appBar: AppBar(
                title:const Text('Message Screen',style: TextStyle(color: Colors.white),),backgroundColor: ColorManger.kSecoundry,leading: IconButton(onPressed: (){
                Get.back();
              }, icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding:const EdgeInsetsDirectional.all(20),
                        decoration: BoxDecoration(
                            color: ColorManger.kSecoundry.withOpacity(0.4),
                            borderRadius: BorderRadiusDirectional.circular(20)
                        ),
                        child: ListView.separated(
                            shrinkWrap: true,


                            itemBuilder: (context,index){
                              if(_userController.listChatModel[index].senderId==_userController.userModel.uid){
                                return buildMyMessage(_userController.listChatModel[index]);
                              }
                              else{
                                return buildMessage(_userController.listChatModel[index]);

                              }
                            },
                            separatorBuilder: (context,index)=>const SizedBox(
                              height: 20,
                            ),
                            itemCount: _userController.listChatModel.length),

                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding:const EdgeInsetsDirectional.only(
                          start: 7
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer ,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 1

                          ),
                          borderRadius: BorderRadius.circular(15 )
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){

                            },
                            child:const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.image, color: Colors.grey,),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _messageController,
                              decoration:const InputDecoration(
                                  hintText: 'type your message here...',
                                  border: InputBorder.none
                              ),
                            ),

                          ),
                          Container(
                            color: ColorManger.kSecoundry,
                            height: 60,
                            width: 60,

                            child: IconButton(
                                onPressed: (){
                                  if(_messageController.text.isNotEmpty){
                                    _userController.sendMessage(receiverId: widget.recieverId, dateTime: DateTime.now().toString(), text: _messageController.text);
                                    _messageController.clear();

                                  }else{
                                    Utils.myToast(title: 'Message is Requierd');
                                  }

                                },
                                icon:const Icon(
                                  Icons.send,
                                  color: Colors.white,

                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

            )));
      },
    );
  }
  Widget buildMessage(ChatModel model)=> Align(
    alignment: AlignmentDirectional.centerStart,
    child: Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYP-KKtRJXm9qK7k2_PA1utxbxWdpzGIdulQ&s'),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          padding:const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5
          ),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius:const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),



              )
          ),
          child: Text(
            '${model.text}',
            style:const TextStyle(
                fontSize: 18
            ),
          ),
        ),
      ],
    ),
  );
  Widget buildMyMessage(ChatModel model)=>  Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Row(

      textDirection: TextDirection.rtl,
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYP-KKtRJXm9qK7k2_PA1utxbxWdpzGIdulQ&s'),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          padding:const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5
          ),
          decoration:const BoxDecoration(
              color: ColorManger.kSecoundry,
              borderRadius:const BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),



              )
          ),
          child: Text(
            '${model.text}',
            style:const TextStyle(
                color: Colors.white,
                fontSize: 18
            ),
          ),
        ),
      ],
    ),
  );
}
