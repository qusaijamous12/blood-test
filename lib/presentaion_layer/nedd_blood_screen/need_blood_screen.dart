import 'package:blood_test/presentaion_layer/donate_screen/location_screen.dart';
import 'package:blood_test/presentaion_layer/resources/button_manger/my_button.dart';
import 'package:blood_test/presentaion_layer/welcome_screen/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_screen/login_screen.dart';
import '../resources/color_ manger/color_manger.dart';

class NeedBloodScreen extends StatefulWidget {
  const NeedBloodScreen({super.key});

  @override
  State<NeedBloodScreen> createState() => _NeedBloodScreenState();
}

class _NeedBloodScreenState extends State<NeedBloodScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _reasonForTransfusion;
  String? _knownBloodType;
  bool _historyOfReactions = false;
  String? _currentCondition;
  bool _pregnant = false;
  String? _typeOfBloodRequired;
  String? _currentMedications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManger.kSecoundry,
        title:const Text('Blood Transfusion Form',style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500
        ),),
        actions: [
          IconButton(onPressed: (){
            Get.offAll(()=>const WelcomeScreen());
          }, icon:const Icon(Icons.login_outlined,color: Colors.white,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const  Text(
                'Please fill the following fields to request need blood',
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
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'What is the reason you need a blood transfusion?',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _reasonForTransfusion = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the reason';
                  }
                  return null;
                },
              ),
             const SizedBox(height: 16),

              // Do you know your blood type?
              DropdownButtonFormField<String>(
                decoration:const InputDecoration(
                  labelText: 'Do you know your blood type?',
                  border: OutlineInputBorder(),
                ),
                value: _knownBloodType,
                onChanged: (String? newValue) {
                  setState(() {
                    _knownBloodType = newValue;
                  });
                },
                items: ['A', 'B', 'AB', 'O', 'Don\'t Know']
                    .map((bloodType) {
                  return DropdownMenuItem(
                    value: bloodType,
                    child: Text(bloodType),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your blood type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // History of reactions to blood transfusions
              Row(
                children: [
                 const Text('Have you had reactions to past blood transfusions?'),
                  Checkbox(
                    value: _historyOfReactions,
                    onChanged: (bool? value) {
                      setState(() {
                        _historyOfReactions = value!;
                      });
                    },
                  ),
                ],
              ),
            const  SizedBox(height: 16),

              // Current medical condition
              TextFormField(
                decoration:const InputDecoration(
                  labelText: 'Do you have a current medical condition?',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _currentCondition = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe your current medical condition';
                  }
                  return null;
                },
              ),
             const SizedBox(height: 16),

              // Are you pregnant?
              Row(
                children: [
                 const Text('Are you currently pregnant?'),
                  Radio<String>(
                    value: 'Yes',
                    groupValue: _pregnant ? 'Yes' : null,
                    onChanged: (value) {
                      setState(() {
                        _pregnant = value == 'Yes';
                      });
                    },
                  ),
                 const Text('Yes'),
                  Radio<String>(
                    value: 'No',
                    groupValue: _pregnant ? 'No' : null,
                    onChanged: (value) {
                      setState(() {
                        _pregnant = value == 'No';
                      });
                    },
                  ),
                const  Text('No'),
                ],
              ),
            const  SizedBox(height: 16),

              // Type of blood required (Red Cells, Plasma, Platelets, etc.)
              DropdownButtonFormField<String>(
                decoration:const InputDecoration(
                  labelText: 'What type of blood product do you need?',
                  border: OutlineInputBorder(),
                ),
                value: _typeOfBloodRequired,
                onChanged: (String? newValue) {
                  setState(() {
                    _typeOfBloodRequired = newValue;
                  });
                },
                items: ['Red Blood Cells', 'Plasma', 'Platelets', 'Don\'t Know']
                    .map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the type of blood product';
                  }
                  return null;
                },
              ),
             const SizedBox(height: 16),

              // List of current medications
              TextFormField(
                decoration:const InputDecoration(
                  labelText: 'Are you currently taking any medications?',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _currentMedications = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please list any medications you are currently taking';
                  }
                  return null;
                },
              ),
            const  SizedBox(height: 16),

              // Submit Button
              myButton(title: 'Next', onTap: (){
                Get.to(()=>const LocationScreen(isDonate: false,));
              })
            ],
          ),
        ),
      ),
    );
  }
}
