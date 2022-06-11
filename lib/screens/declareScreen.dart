import 'dart:convert';
import 'package:CovidTracker/services/apiServices/apiFunctions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../utils/color.dart';
import '../resources/conn.dart';
import '../utils/loading.dart';
import '../resources/popups.dart';

class declareScreen extends StatefulWidget {
  const declareScreen({Key? key}) : super(key: key);

  @override
  _declareScreenState createState() => _declareScreenState();
}

class _declareScreenState extends State<declareScreen> {
  String dropdown = 'corona';
  String virusSelected = 'corona';
  List allViruses = [];
  List id = [];
  List virusName = [];
  bool isLoading = true;
  String token = '';
  String SelectedId = '';

  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  getViruses() async {
      final ConnectivityResult result = await Connectivity().checkConnectivity();

                        if(result!=ConnectivityResult.none){
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token") ?? '';
    print(token);
    ApiFunctions a = ApiFunctions();
    var result = await a.getViruses(token);
    setState(() {
      allViruses = json.decode(result.body) as List;
    });
    print(result.body);
    for (var a in allViruses) {
      var g = json.encode(a);
      print(g);
      var c = json.decode(g);
      print(c);

      id.add(c['uid']);
      virusName.add(c['virusName']);
    }
    setState(() {
      dropdown = virusName[0];
      virusSelected = virusName[0];
      isLoading = false;
    });
    print(virusName);}else{
      setState(() {
        isLoading = false;
      });
    
    }
  
  }

  void didChangeDependencies() {
    precacheImage(AssetImage("assets/images/declarer.png"), context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    
    super.initState();
    getViruses();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return isLoading
        ? Loading()
        : conn(
          clas: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: h * 0.150),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/declarer.png",
                        width: h * 0.35,
                      ),
                      Padding(
                          padding: EdgeInsets.all(h * 0.04),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(h * 0.01),
                                child: Text(
                                  "Vous avez fait un test d'un virus et il est positif?",
                                  style: TextStyle(
                                    color: ybcolor,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                "Merci de vous déclarer pour que les personnes que vous avez croisé soient alértées. Prenez soin de vous!",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: h * 0.06),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: h * 0.06,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: DropdownButtonHideUnderline(
                                            child: GFDropdown(
                                              icon: Icon(
                                                  Icons.arrow_downward_outlined),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: h * 0.02),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              border: const BorderSide(
                                                  color: ybcolor, width: 2),
                                              dropdownButtonColor: Colors.white,
                                              value: virusSelected,
        
                                              onChanged: (newValue) {
                                                setState(() {
                                                  virusSelected = '$newValue';
                                                });
                                              },
                                              items: virusName
                                                  .map((value) =>
                                                      DropdownMenuItem(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                            color: ybcolor,
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontWeight:
                                                                FontWeight.w100,
                                                          ),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ))
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: h * 0.02,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: InkWell(
                                            splashColor: ybcolorOp,
                                            child: OutlineGradientButton(
                                              child: GradientText(
                                                'J\'ai ce virus',
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: h * 0.04,
                                                  vertical: h * 0.02),
                                              onTap: () {
                                                for (int i = 0;
                                                    i < virusName.length;
                                                    i++) {
                                                  if (virusSelected ==
                                                      virusName[i]) {
                                                    SelectedId = id[i];
                                                  }
                                                  print('virus: ' + SelectedId);
                                                }
                                                showContaminationPopup(
                                                    context, SelectedId, token);
                                              },
                                            ),
                                          ),
                                        ),
                                      ]))
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
        );
  }
}
