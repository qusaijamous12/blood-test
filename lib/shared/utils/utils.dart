import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../presentaion_layer/resources/color_ manger/color_manger.dart';

class Utils{

  static Future<bool?> myToast({required String title})async{

    return await  Fluttertoast.showToast(
        msg: "${title}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManger.kSecoundry,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }

}