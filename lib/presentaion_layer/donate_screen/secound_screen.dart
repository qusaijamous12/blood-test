import 'package:blood_test/presentaion_layer/donate_screen/location_screen.dart';
import 'package:blood_test/presentaion_layer/resources/button_manger/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_screen/login_screen.dart';
import '../resources/color_ manger/color_manger.dart';

class SecoundScreen extends StatefulWidget {
  const SecoundScreen({super.key,required this.firstName,
  required this.lastName,
  required this.dateOfBirth,
  required this.gender,
  required this.phoneNumber,
  required this.emailAddress});
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String gender;
  final String phoneNumber;
  final String emailAddress;


  @override
  State<SecoundScreen> createState() => _SecoundScreenState();
}

class _SecoundScreenState extends State<SecoundScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phone = '';
  String _dob = '';
  String _gender = '';
  bool _isHealthy = false;
  bool _isPregnant = false;
  bool _isSmoker = false;
  bool _hasChronicConditions = false;
  // Medical Conditions
  List<String> _selectedConditions = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
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
       body:   Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              // Eligibility Check: Healthy
              CheckboxListTile(
                title:const Text('Do you feel healthy and well today?',style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),),
                value: _isHealthy,
                onChanged: (bool? value) {
                  setState(() {
                    _isHealthy = value!;
                  });
                },
              ),
              const  SizedBox(
                height: 20,
              ),

              // Eligibility Check: Pregnant
              CheckboxListTile(
                title:const Text('Are you currently pregnant or breastfeeding?',style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                )),
                value: _isPregnant,
                onChanged: (bool? value) {
                  setState(() {
                    _isPregnant = value!;
                  });
                },
              ),
              const  SizedBox(
                height: 20,
              ),

              // Lifestyle: Do you smoke?
              CheckboxListTile(
                title:const Text('Do you smoke or consume alcohol?',style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                )),
                value: _isSmoker,
                onChanged: (bool? value) {
                  setState(() {
                    _isSmoker = value!;
                  });
                },
              ),
             const  SizedBox(
                height: 20,
              ),

              // Medical Conditions
              const Padding(
              padding:  EdgeInsets.only(left: 12),
              child:   Text('Do you have any medical conditions? (Select all that apply)',style:  TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  fontSize: 20
              ),),
            ),

              const SizedBox(
                height: 20,
              ),
              CheckboxListTile(
                title:const Text('Diabetes',style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                )),
                value: _selectedConditions.contains('Diabetes'),
                onChanged: (bool? value) {
                  setState(() {
                    if (value!) {
                      _selectedConditions.add('Diabetes');
                    } else {
                      _selectedConditions.remove('Diabetes');
                    }
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CheckboxListTile(
                title:const Text('Hypertension',style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                )),
                value: _selectedConditions.contains('Hypertension'),
                onChanged: (bool? value) {
                  setState(() {
                    if (value!) {
                      _selectedConditions.add('Hypertension');
                    } else {
                      _selectedConditions.remove('Hypertension');
                    }
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CheckboxListTile(
                title:const Text('Heart disease',style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                )),
                value: _selectedConditions.contains('Heart disease'),
                onChanged: (bool? value) {
                  setState(() {
                    if (value!) {
                      _selectedConditions.add('Heart disease');
                    } else {
                      _selectedConditions.remove('Heart disease');
                    }
                  });
                },
              ),
              // Add more conditions as necessary

              // Consent & Acknowledgment
              const SizedBox(
                height: 20,
              ),
              CheckboxListTile(
                title:const Text('I consent to the collection and use of my personal and medical data for the purpose of blood donation and safety.',style: TextStyle(
                color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                )),
                value: _hasChronicConditions,
                onChanged: (bool? value) {
                  setState(() {
                    _hasChronicConditions = value!;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),

              // Submit Button
              myButton(title: 'Next', onTap: (){
                Get.to(()=> LocationScreen(firstName: widget.firstName,lastName: widget.lastName,phoneNumber: widget.phoneNumber,gender: widget.gender,email: widget.emailAddress,dateOfBirth: widget.dateOfBirth,isDonate: true,));
              })
            ],
          ),
        ),
      ),


    );
  }
}
