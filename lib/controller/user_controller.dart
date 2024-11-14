import 'package:blood_test/model/history_model.dart';
import 'package:blood_test/presentaion_layer/phone_login/phone_login.dart';
import 'package:blood_test/presentaion_layer/welcome_screen/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/message_model.dart';
import '../model/user_model.dart';
import '../presentaion_layer/admin_screen/admin_screen.dart';
import '../presentaion_layer/login_screen/login_screen.dart';
import '../shared/utils/utils.dart';

class UserController extends GetxController{
  final _isLoading=RxBool(false);
  final _userModel=Rx<UserModel>(UserModel());
  final _verfivationId = RxString('');
  final _historyModel=RxList<HistoryModel>([]);
  final _historyAdminModel=RxList<HistoryModel>([]);
  final _listUsers=RxList<UserModel>([]);
  final _listChatModel=RxList<ChatModel>([]);
  final _userModelAdmin=Rx<UserModel>(UserModel());
  final _historyNeedBlood=RxList<HistoryModel>([]);


  Future<void> login({required String email,required String password})async{
    _isLoading(true);
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password).then((value)async{
      if(value!=null){
        if(value.user?.uid!=null){
          await getUserData(uid: value.user!.uid);
          Utils.myToast(title: 'Login Success');
          if(_userModel.value.status==0){
            Get.offAll(()=>const WelcomeScreen());

          }else{
            Get.offAll(()=>const AdminScreen());

          }



        }
      }

    }).catchError((error){
      print('there is an error when user Login');
      Utils.myToast(title: 'Login Failed');
    });
    _isLoading(false);
  }

  Future<void> getUserData({required String uid})async{
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value){
      if(value.data() != null){
        _userModel(UserModel.fromJson(value.data()!));

      }

    }).catchError((error){
      print('there is an error when get user data !!');
    });
  }

  Future<void> register({required String email,required String password,required String name,required String phone})async{
    _isLoading(true);
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value)async{
      if(value.user?.uid!=null){
        await  FirebaseFirestore.instance.collection('users').doc(value.user?.uid).set({
          'email':email,
          'phone':phone,
          'status':0,
          'name':name,
          'uid':value.user?.uid,
          'profile_image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYP-KKtRJXm9qK7k2_PA1utxbxWdpzGIdulQ&s'
        }).then((value){
          Utils.myToast(title: 'Register Success');
          Get.offAll(()=>const LoginScreen());

        }).catchError((error){
          Utils.myToast(title: 'Register Failed');
        });

      }

    }).catchError((error){
      print('there is an error when register$error');
      Utils.myToast(title: 'Register Failed');
    });
    _isLoading(false);
  }

  Future<void> getUserDataBasedEmail({required String email})async{
    _isLoading(true);
    try{
      print('asasas');
      final result=await FirebaseFirestore.instance.collection('users').get();


      if(result.docs!=null){
        print(result.docs);
        print('cscsd');
        result.docs.forEach((element){
          if(element['email']==email){
            _userModel(UserModel.fromJson(element.data()));
            print('_userModel.value.name${_userModel.value.name}');
            Get.offAll(()=>const PhoneLogin());
          }

        });

      }
      else{
        Utils.myToast(title: 'There is an error ');
      }
      _isLoading(false);

    }catch(e){
      print('sasasa');
      Utils.myToast(title: 'Enter Valid Email');

    }

  }

  Future<bool> sendDonateRequest({required String firstName,required String lastName, required String gender, required String dateOfBirth,required String phoneNumber,required String lat,required String long,required String email})async{
    _isLoading(true);
    await FirebaseFirestore.instance.collection('donate').doc(_userModel.value.uid).set({
      'first_name':firstName,
      'last_name':lastName,
      'gender':gender,
      'date_of_birth':dateOfBirth,
      'phone_number':phoneNumber,
      'lattiude':lat,
      'longtitude':long,
      'email':email,
      'uid':_userModel.value.uid

    }).then((value){
      return true;
    }).catchError((error){
      print('error $error');

      return false;
    });
    _isLoading(false);
    return true;

  }

  Future<bool> sendNeedBloodRequest({required String lat,required String long})async{
    _isLoading(true);
    await FirebaseFirestore.instance.collection('need_blood').doc(_userModel.value.uid).set({
      'first_name':_userModel.value.name,
      'phone_number':_userModel.value.phone,
      'lattiude':lat,
      'longtitude':long,
      'email':_userModel.value.email,
      'uid':_userModel.value.uid

    }).then((value){
      return true;
    }).catchError((error){
      print('error $error');

      return false;
    });
    _isLoading(false);
    return true;


}

  Future<void> getAllUserHistory()async{
    _historyModel.clear();
    _isLoading(true);
    await FirebaseFirestore.instance.collection('donate').get().then((value){

      value.docs.forEach((value){
        if(value['uid']==_userModel.value.uid){
          _historyModel.add(HistoryModel.fromJson(value.data()));
        }
      });
    }).catchError((error){
      print('there is an error when get all history donate $error');
    });
    _isLoading(false);
  }

  Future<void> getAllUserNeedBlood()async{
    _historyNeedBlood.clear();
    _isLoading(true);
    await FirebaseFirestore.instance.collection('need_blood').get().then((value){

      value.docs.forEach((value){
          _historyNeedBlood.add(HistoryModel.fromJson(value.data()));

        print('_historyNeedBlood.length${_historyNeedBlood.length}');
      });
    }).catchError((error){
      print('there is an error when get all history donate $error');
    });
    _isLoading(false);
  }


  Future<void> getAllHistory()async{
    _historyAdminModel.clear();
    _isLoading(true);
    await FirebaseFirestore.instance.collection('donate').get().then((value){
      value.docs.forEach((value){
        _historyAdminModel.add(HistoryModel.fromJson(value.data()));
      });

    }).catchError((error){
      print('there is an error when get all history donate $error');
    });
    _isLoading(false);
  }

  Future<void> getAllUsersAdmin()async{
    _listUsers.clear();
    _isLoading(true);
   await FirebaseFirestore.instance.collection('users').get().then((value){
      value.docs.forEach((value){
        if(value['status']==0){
          _listUsers.add(UserModel.fromJson(value.data()));
        }
        print('ssss${_listUsers.length}');
      });

    }).catchError((error){
      print('there is an error when get all users !!${error}');
    });
    _isLoading(false);

  }

  Future<void> getAdmin()async{
    _isLoading(true);
    await FirebaseFirestore.instance.collection('users').get().then((value){
      value.docs.forEach((value){
        if(value['status']==1){
          _userModelAdmin(UserModel.fromJson(value.data()));
        }
      });
    }).catchError((error){
      print('there is an error $error');
    });
    _isLoading(false);
  }

  void sendMessage({required String receiverId, required String dateTime, required String text, String ?image}){
    ChatModel chatModel = ChatModel(
      text: text,
      dateTime: dateTime,
      senderId: _userModel.value.uid,
      reciverId: receiverId,

    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(_userModel.value.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(chatModel.toMap()).then((value) {
      // _listChatModel.add(ChatModel(text: text,dateTime: dateTime,senderId: uid,reciverId: receiverId));
      print('message send Success !');


    }).catchError((error){
      print('there is an error when send message !');


    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(_userModel.value.uid)
        .collection('message')
        .add(chatModel.toMap()).then((value) {
      print('message Send Success !');

    }).catchError((error){

      print('there is an error when send message !');
    });


  }

  Future getMessages({required String receiverId})async{
    await FirebaseFirestore.instance.
    collection('users').
    doc(_userModel.value.uid).
    collection('chats').
    doc(receiverId).
    collection('message').orderBy('dateTime').
    snapshots()
        .listen((event) {
      _listChatModel.clear();
      event.docs.forEach((element) {
        _listChatModel.add(ChatModel.fromJson(element.data()));


      });
      print('Get Messages Success State ');

    });
  }







  //Otp Code

  Future<void> sumbitPhoneNumber({required String phoneNumber}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+962$phoneNumber',
      timeout: const Duration(seconds: 30),
      verificationCompleted: verficationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verficationCompleted(PhoneAuthCredential credential) async {
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException e) {
    print('Verification failed: ${e.message}');
  }

  void codeSent(String verficationId, int? resendToken) {
    Utils.myToast(title: 'Code Send');
    _verfivationId(verficationId);
  }

  void codeAutoRetrievalTimeout(String verficationId) {
    print('Verification timed out');
  }

  Future<bool> sumbitOTP({required String otpCode}) async {
    _isLoading(true);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verfivationId.value,
        smsCode: otpCode,
      );
      return await signIn(credential);
    } finally {
      _isLoading(false);
    }
  }

  Future<bool> signIn(PhoneAuthCredential credential) async {
    try {
      final authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      if (authResult.user != null) {
        Utils.myToast(title: 'Success');
        Get.offAll(()=>const WelcomeScreen());
      }
      return false;
    } catch (error) {

      Utils.myToast(title: 'Sign In Failed');
      return false;
    }
  }




  bool get isLoading=>_isLoading.value;
  UserModel get userModel=>_userModel.value;
  List<HistoryModel> get historyNeedBlood=>_historyNeedBlood;

  List<HistoryModel> get historyModel=>_historyModel;
  List<HistoryModel> get historyAdminModel=>_historyAdminModel;
  List<UserModel> get listUsers=>_listUsers;
  List<ChatModel> get listChatModel=>_listChatModel;
  UserModel get userAdminModel=>_userModelAdmin.value;



}