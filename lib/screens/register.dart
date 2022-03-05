
import 'package:CovidTracker/resources/color.dart';

import 'package:CovidTracker/resources/errorMessage.dart';
import 'package:CovidTracker/resources/infoText.dart';
import 'package:CovidTracker/resources/submitButton.dart';
import 'package:CovidTracker/screens/acceuil.dart';
import 'package:CovidTracker/screens/registerSecondStep.dart';
import 'package:flutter/material.dart';
import 'package:CovidTracker/screens/login.dart';
import 'package:provider/provider.dart';

import '../DAL/utilisateur.dart';
import '../resources/conn.dart';
import '../resources/logo.dart';
import 'home.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  int age = 0;
  late DateTime birth = DateTime.now();

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  late String value = "";
  late bool submit = false;
  late String newValue="homme";
  List gender = ["homme", "femme"];
  late DateTime _dateTime = DateTime.now();
  TextEditingController dateCtl = TextEditingController();
  TextEditingController name = TextEditingController();
  late String genre;
  String dropdownValue = 'Homme';
  String holder = '';

  void getDropDownItem() {
    setState(() {
      holder = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    Widget wrapContent=Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          splashRadius: 1,
          icon: Icon(Icons.chevron_left_rounded,
            size: h*0.040,),
          onPressed: () => Navigator.pop(context),
          color: ybcolor,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: h*0.040),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 logo()
                ],
              ),
            ),
            if (!isKeyboard)
              FractionallySizedBox(
                child: Padding(
                  padding: EdgeInsets.only(top: h*0.060),
                  child: Image.asset(
                    "assets/images/register.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                widthFactor: 0.77,
              ),
            if (!isKeyboard)
              Padding(
                padding: EdgeInsets.only(top: h*0.040),
                child: infoText(
                  text: "Entrez vos informations",
                  size: h*0.017,
                ),
              ),
            Padding(padding: EdgeInsets.only(top: h*0.025)),
            FractionallySizedBox(
              widthFactor: 0.95,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(h*0.035, h*0.005, h*0.035, 0),
                  child: TextField(
                    controller: name,
                    textAlign: TextAlign.center,
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: 'Entrez votre nom complet',
                      contentPadding: EdgeInsets.only(top: h*0.002, right: h*0.040),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.account_circle_outlined,
                        color: ybcolor,
                      ),
                      hintStyle: TextStyle(
                          fontSize: h*0.015,
                          fontFamily: 'Montserrat',
                          color: Colors.grey[400]),
                      fillColor: Colors.white70,
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(50.0)),
                        borderSide: BorderSide(color: ybcolor, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(50.0)),
                        borderSide: BorderSide(color: ybcolor, width: 2),
                      ),
                    ),
                    onChanged: (text) {
                      value = text;
                    },
                  ),
                ),
              ),
            ),
            if (submit == true && name.text == "")
              errorMessage("Veuillez entrez un nom valide!"),
            Padding(
                padding: EdgeInsets.fromLTRB(h*0.035, h*0.015, h*0.035, 0),
                child: FractionallySizedBox(
                  widthFactor: 0.95,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: dateCtl,
                    decoration: InputDecoration(
                      hintText: 'Entrez votre date de naissance',
                      contentPadding: EdgeInsets.only(right: h*0.010, left: h*0.020),
                      hintStyle: TextStyle(
                          fontSize: h*0.015,
                          fontFamily: 'Montserrat',
                          color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.date_range, color: ybcolor),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                          color: ybcolor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: ybcolor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    onTap: () async {
                      DateTime? date = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());

                      date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      var formate2 =
                          "${date?.day}-${date?.month}-${date?.year}";
                      dateCtl.text = "$formate2";
                      birth = date!;
                    },
                  ),
                )),
            if (submit == true && dateCtl.text == "")
              errorMessage("Entrez une date valide"),
            Padding(
                padding: EdgeInsets.fromLTRB(h*0.045, h*0.015, h*0.045, 0),
                child: SizedBox(
                  height: h*0.054,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors
                              .white,
                          border: Border.all(
                              color: ybcolor,
                              width: 2),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: <BoxShadow>[]),
                      child: Padding(
                          padding: EdgeInsets.only(left: h*0.030, right: h*0.030),
                          child: DropdownButton(
                            hint: Text('Genre'),
                            value: newValue,
                            items: [
                              DropdownMenuItem(
                                child: Text(
                                  "Homme",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Montserrat',
                                      color: Colors.black),
                                ),
                                value: "homme",
                              ),
                              DropdownMenuItem(
                                  child: Text(
                                    "Femme",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Montserrat',
                                        color: Colors.black),
                                  ),
                                  value: "femme"),
                            ],
                            onChanged: (value) => setState(() {
                              newValue = "$value";
                              getDropDownItem();
                            }),
                            icon: Icon(Icons.arrow_circle_down_sharp),
                            iconEnabledColor: ybcolor,
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Montserrat',
                                fontSize: 16
                            ),
                            dropdownColor: Colors.white,
                            underline: Container(),
                            isExpanded: true,
                          ))),
                )),
            Padding(
              padding: EdgeInsets.only(top: h*0.040),
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: submitButton(
                  text: "Continuer",
                  press: () {
                    setState(() {
                      age = calculateAge(birth);
                      submit = true;
                      if (name.text != "" && dateCtl.text != "")
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => registerSecondStep(
                                    name.text, age, newValue,birth)));
                    });
                  },
                  color: ybcolor,
                  textColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: h*0.030, bottom: h*0.020),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => login()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Déja inscrit? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Connectez vous.',
                        style: TextStyle(
                          color: ybcolor,
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
    final use = Provider.of<utilisateur?>(context);
    if (use == null)
      return SafeArea(
        child: conn(clas:wrapContent),
      );
    else {
      return acceuilScreen();
    }
  }
}
