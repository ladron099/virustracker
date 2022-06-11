import 'dart:convert';
import 'package:CovidTracker/services/apiServices/apiFunctions.dart';
import 'package:CovidTracker/utils/loading.dart';
import 'package:CovidTracker/screens/acceuil.dart';
import 'package:CovidTracker/screens/maintenance.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../utils/color.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {

  String fullname='';
  bool loading=false;
String error='';
  TextEditingController dateinput = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController ename = TextEditingController();
  String token='';
  _getusername()async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      ename.text= (prefs.getString('fullname') ?? '');
      email.text=(prefs.getString('email') ?? '');
      dateinput.text=(prefs.getString('birthDate') ?? '');
      token=(prefs.getString('token') ?? '');
    });
  }


  bool active=false;


  @override
  void initState() {
    super.initState();
    _getusername();
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;


    Widget wrapContent=Text('');
    if(!active)
      wrapContent=Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Profile",
              style: TextStyle(
                color: ybcolor,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              splashRadius: 1,
              icon: Icon(
                Icons.close,
              ),
              onPressed: () => Navigator.pop(context),
              color: ybcolor,
            ),
          ),
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              reverse: true,
              child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(h*0.065, h*0.030, h*0.020, h*0.020),
                    child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children:[ Text(
                        'Informations personelles',
                        style: TextStyle(
                          color: ybcolor,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize:14,
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(h*0.040,0,h*0.040,0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Padding(
                               padding: EdgeInsets.fromLTRB(h*0.030, h*0.020, h*0.020, 0),
                               child: Text(
                                    'Nom Complet',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ybcolor,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize:13,
                                    ),
                                  ),
                             ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(h*0.020, h*0.010, h*0.020, h*0.0),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ybcolor.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(h*0.010),
                                    child: TextFormField(
                                      controller: ename,
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.grey[700],
                                        fontSize: 15,
                                      ),
                                      cursorColor: ybcolor,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(h*0.01, h*0.0, h*0.020, h*0.020),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              /////////----------------------END OF FIRST INPUT----------/////////
                              Padding(
                                padding: EdgeInsets.fromLTRB(h*0.030, h*0.020, h*0.020, 0),
                                child: Text(
                                  'Email',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: ybcolor,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize:13,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(h*0.020, h*0.010, h*0.020, h*0.020),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ybcolor.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(h*0.010),
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.grey[700],
                                        fontSize: 15,
                                      ),
                                      cursorColor: ybcolor,
                                      controller: email,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(h*0.01, h*0.0, h*0.020, h*0.020),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ///--------END OF SECOND INPUT---///////
                              Padding(
                                padding: EdgeInsets.fromLTRB(h*0.030, 0, h*0.020, 0),
                                child: Text(
                                  'Date de naissance',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: ybcolor,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize:13,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(h*0.020, h*0.010, h*0.020, h*0.020),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ybcolor.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(h*0.010),
                                    child: TextFormField(
                                      readOnly: true,
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.grey[700],
                                        fontSize: 15,
                                      ),
                                      showCursor: false,
                                      enableInteractiveSelection: false,
                                       controller: dateinput,
                                      decoration: InputDecoration(
                                        hintText: dateinput.text,
                                        contentPadding: EdgeInsets.fromLTRB(h*0.01, h*0.0, h*0.020, h*0.015),
                                        border: InputBorder.none,
                                      ),
                                      onTap: () async {
                                        DateTime? date = DateTime(1900);
                                        date = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100));
                                        var retrievedDate =
                                            "${date?.day}-${date?.month}-${date?.year}";
                                        if(retrievedDate != "null-null-null"){
                                          setState(() {
                                            dateinput.text="$retrievedDate";
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding:  EdgeInsets.only(top:h*0.03),
                      child: Text(error,
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: gradientcolor,
                          borderRadius: new BorderRadius.circular(50.0),
                        ),
                        child: MaterialButton(
                          highlightColor: ybcolor,
                          shape: StadiumBorder(),
                          textColor: Colors.white,
                          child: Text('Enregistrer',
                            style:
                            TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          onPressed: () async {  final ConnectivityResult result = await Connectivity().checkConnectivity();

                        if(result!=ConnectivityResult.none){
                            setState(() {
                              loading=true;
                            });
                            ApiFunctions apiEdit = ApiFunctions();
                          var aa=  await apiEdit.modifyUser(token, email.text,ename.text, dateinput.text, 'test');

                            if(aa.statusCode==200){
                              loading=false;
                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setString('email', email.text);
                            await prefs.setString('birthDate', dateinput.text);
                            bool startService = await prefs.getBool('startService') ?? false;
                              await prefs.setString('fullname', ename.text);
                              var names = ename.text.split(' ');
                              var firstName = names[0];
                              await prefs.setString('firstName',firstName);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => acceuilScreen('Votre compte a été modifié avec succès', startService)));
                            }
                            else{
                            setState(() {
                              loading=false;
                              var token0;
                              final Map<String, dynamic> data = json.decode(aa.body);
                              error=data['msg'];
                              print(data);
                              print('{$token0.body}');
                            });
                            }
}else{
     setState(() {
                            loading=false;
                             Fluttertoast.showToast(
          msg: 'Une erreur est survenue. Veuillez verifiez votre connexion internet et réssayer.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: danger,
          textColor: Colors.white,
          fontSize: 15);
                          });
}
                          },
                        ),
                      ),
                      OutlineGradientButton(
                        child: GradientText(
                          'Annuler',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w100,
                          ),
                          textAlign: TextAlign.center,
                          colors: [ybcolor2, ybcolor],
                        ),
                        gradient: gradientcolor,
                        strokeWidth: 2,
                        radius: Radius.circular(25),
                        padding: EdgeInsets.symmetric(horizontal: h*0.024, vertical: h*0.017),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:h*0.050),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Copyright © VIRUS TRACKER 2021-2022',
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.3),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize:10,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      );
    else wrapContent=maintenance();
      return loading ? Loading(): SafeArea(child:wrapContent);

}}
