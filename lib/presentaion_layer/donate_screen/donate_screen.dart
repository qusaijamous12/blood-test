import 'package:blood_test/presentaion_layer/donate_screen/secound_screen.dart';
import 'package:blood_test/presentaion_layer/login_screen/login_screen.dart';
import 'package:blood_test/presentaion_layer/resources/button_manger/my_button.dart';
import 'package:blood_test/presentaion_layer/resources/color_%20manger/color_manger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../shared/utils/utils.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final _firstNameController=TextEditingController();
  final _lastNameController=TextEditingController();
  final _dateOfBirthController=TextEditingController();
  final _phoneController=TextEditingController();
  final _emailController=TextEditingController();
  final _locationController=TextEditingController();
  final _genderController=TextEditingController();

 bool isMale=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManger.kSecoundry,
        title:const Text(
          'Donate Blood Screen',
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
        padding: const EdgeInsetsDirectional.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const  Text(
              'Please fill the following fields to request donate blood',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
            ),
           const  SizedBox(
              height: 10,
            ),
           const Text(
              'Please answer these questions',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w300,
                fontSize: 20
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _firstNameController,
              decoration:const InputDecoration(
                // border: InputBorder.none,
                labelText: 'First Name',
                prefixIcon: Icon(Icons.drive_file_rename_outline),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _lastNameController,
              decoration:const InputDecoration(
                // border: InputBorder.none,
                labelText: 'Last Name',
                prefixIcon: Icon(Icons.drive_file_rename_outline),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _dateOfBirthController,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime now = DateTime.now();
                DateTime nextYear = DateTime(now.year + 1, now.month, now.day);

                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: now,
                  firstDate: now,
                  lastDate: nextYear,
                );

                if (selectedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                  _dateOfBirthController.text = formattedDate;
                }
              },

              decoration:const InputDecoration(
                // border: InputBorder.none,
                labelText: 'Date Of Birth',
                prefixIcon: Icon(Icons.drive_file_rename_outline),
              ),
            ),
           const  SizedBox(
              height: 20,
            ),
            const Text(
              'Please Select Your Gender',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  fontSize: 20
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      if(isMale){

                      }else{
                        isMale=!isMale;
                        _genderController.text='Male';
                        print('gender${_genderController.text}');
                        setState(() {

                        });
                      }

                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(20),
                        color:isMale?ColorManger.kSecoundry:Colors.white
                      ),
                    child: Icon(Icons.male,color:isMale?Colors.white:ColorManger.kSecoundry,size: 150,),
                    ),
                  ),

                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      if(isMale){
                        isMale=!isMale;
                        _genderController.text='Female';
                        print('gender${_genderController.text}');
                        setState(() {

                        });
                      }

                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20),
                          color:isMale? Colors.white:ColorManger.kSecoundry,
                        border: Border.all(
                          color: ColorManger.kSecoundry
                        )
                      ),
                      child: Icon(Icons.female,size: 150,color:isMale? ColorManger.kSecoundry:Colors.white,),

                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _phoneController,


              decoration:const InputDecoration(
                // border: InputBorder.none,
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const  SizedBox(
              height: 20,
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

            const  SizedBox(
              height: 30,
            ),
            myButton(title: 'Next', onTap: (){
              if(_firstNameController.text.isNotEmpty&&_lastNameController.text.isNotEmpty&&_dateOfBirthController.text.isNotEmpty&&_genderController.text.isNotEmpty&&_phoneController.text.isNotEmpty&&_emailController.text.isNotEmpty){
                Get.to(()=> SecoundScreen(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  dateOfBirth: _dateOfBirthController.text,
                  gender: _genderController.text,
                  phoneNumber: _phoneController.text,
                  emailAddress: _emailController.text,
                ));
              }else{
                Utils.myToast(title: 'Please Select Gender');
                Utils.myToast(title: 'Please fill all fields');
              }


            })





          ],
        ),
      ),

    );
  }
}
