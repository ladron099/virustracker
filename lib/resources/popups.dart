import 'dart:io';

import 'package:CovidTracker/services/apiServices/apiFunctions.dart';
import 'package:CovidTracker/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/landing.dart';
import '../services/nearbyServices/nearbyServices.dart';
import 'package:intl/intl.dart';

showExitPopup(context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Voulez-vous vraiment quitter ?',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: danger,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      //RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0.r)),
                      onPressed: () {
                        exit(0);
                      },
                      child: Text(
                        "Oui",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                    SizedBox(
                      width: 15.0,
                    ),
                    //             InkWell(onTap: () {},child: Container(
                    // height: 45.h,
                    // width: 70.w,
                    // decoration: BoxDecoration(color,
                    // ),),
                    Expanded(
                        child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: danger, width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onPressed: () {
                        print('no selected');
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Non",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}

showDeletePopup(context, String token) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Voulez-vous vraiment supprimer votre compte ?',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: danger,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      //RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0.r)),
                      onPressed: () async {
                        ApiFunctions a = ApiFunctions();
                        var result = await a.deleteAccount(token);
                        if (result.statusCode == 200) {
                          final sharedPreferences =
                              await SharedPreferences.getInstance();
                              String playerId=await sharedPreferences.getString('fcm')??'';
                              print('now'+playerId);
                          sharedPreferences.clear();
                          sharedPreferences.commit();
                          await sharedPreferences.setInt('initScreen', 1);
                          await sharedPreferences.setString('fcm', playerId);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) => landing()),
                              (Route<dynamic> route) => false);
                        } else {
                          print(result.statusCode);
                          print(result.body);
                        }
                      },
                      child: Text(
                        "Oui",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                    SizedBox(
                      width: 15.0,
                    ),
                    //             InkWell(onTap: () {},child: Container(
                    // height: 45.h,
                    // width: 70.w,
                    // decoration: BoxDecoration(color,
                    // ),),
                    Expanded(
                        child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: danger, width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onPressed: () {
                        //   print('no selected');
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Non",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}

showLogoutPopup(context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Voulez-vous vraiment se déconnecter ?',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: danger,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      //RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0.r)),
                      onPressed: () async {
                        final sharedPreferences =
                            await SharedPreferences.getInstance();
                        if(FlutterBackground.isBackgroundExecutionEnabled){
                          disableBackground();
                        }
                         String playerId=await sharedPreferences.getString('fcm')??'';
                              print('now'+playerId);
                        sharedPreferences.clear();
                        sharedPreferences.commit();
                        await sharedPreferences.setInt('initScreen', 1);
                        await sharedPreferences.setString('fcm', playerId);

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => landing()),
                            (Route<dynamic> route) => false);
                        //   print('${sharedPreferences.getString('name')}');
                      },
                      child: Text(
                        "Oui",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                    SizedBox(
                      width: 15.0,
                    ),
                    //             InkWell(onTap: () {},child: Container(
                    // height: 45.h,
                    // width: 70.w,
                    // decoration: BoxDecoration(color,
                    // ),),
                    Expanded(
                        child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: danger, width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onPressed: () {
                        print('no selected');
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Non",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}

Future<void> disableBackground() async {
  bool success = await FlutterBackground.disableBackgroundExecution();
}

showContaminationPopup(context, String virusId, String token) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Étes vous sur de votre choix ?',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: danger,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      //RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0.r)),
                      onPressed: () async {
                        
                            Navigator.of(context).pop();
                        var position = determinePosition();
                        double latitude = 0;
                        double longitude = 0;
                        ApiFunctions a = ApiFunctions();
                        String contaminationTime =
                            DateFormat('yyyy-MM-dd hh:mm:ss.s')
                                .format(DateTime.now());
                        String token2 = '';
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        token2= prefs.getString('token') ?? '';
                        print('virus: ' + virusId);
                        position.then((value) async {
                          latitude = (value?.latitude) ?? 0.0;
                          longitude= (value?.longitude) ?? 0.0;
                          print(latitude);
                          print(longitude);
                          var response = await a.addContamination(
                              token2, virusId, contaminationTime,latitude,longitude);
                          if (response.statusCode == 200) {
                            Fluttertoast.showToast(
                                msg: 'Votre contamination a été enregistrée',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 15);

                          } else {
                            print(contaminationTime);
                            print(token);
                            print(virusId);
                            print(response.statusCode);
                            print(response.body);
                          }
                        });

                      },
                      child: Text(
                        "Oui",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                    SizedBox(
                      width: 15.0,
                    ),
                    //             InkWell(onTap: () {},child: Container(
                    // height: 45.h,
                    // width: 70.w,
                    // decoration: BoxDecoration(color,
                    // ),),
                    Expanded(
                        child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: danger, width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onPressed: () {
                        print('No selected');
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Non",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}
